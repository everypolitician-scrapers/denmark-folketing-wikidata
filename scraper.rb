require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri/cached'

OpenURI::Cache.cache_path = '.cache'

def noko_for(url)
  Nokogiri::HTML(open(URI.escape(URI.unescape(url))).read) 
end

def wikinames_from(url)
  noko = noko_for(url)
  names = noko.xpath('//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title').map(&:text)
  abort "No names" if names.count.zero?
  names
end

def fetch_info(names)
  WikiData.ids_from_pages('da', names).each do |name, id|
    data = WikiData::Fetcher.new(id: id).data('da') rescue nil
    unless data
      warn "No data for #{name} #{id}"
      next
    end
    data[:original_wikiname] = name
    ScraperWiki.save_sqlite([:id], data)
  end
end

names = wikinames_from('https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2015')

fetch_info names.uniq
