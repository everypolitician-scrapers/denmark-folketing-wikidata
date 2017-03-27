require 'wikidata/fetcher'

wp2015 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2015',
  xpath: '//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title',
)

wp2011 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2011',
  xpath: '//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title',
)

by_id = %w(Q28167615 Q2037525 Q22956366 Q16167420 Q28528045 Q23311251 Q331736 Q12304459)

scraped = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/denmark-folketing-wp', column: 'wikiname')
category = WikiData::Category.new( "Kategori:Folketingsmedlemmer i 2010'erne", 'da').member_titles

EveryPolitician::Wikidata.scrape_wikidata(ids: by_id, names: { da: wp2015 | wp2011 | scraped | category })
