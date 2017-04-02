require 'wikidata/fetcher'

wp2015 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2015',
  xpath: '//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title',
)

wp2011 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2011',
  xpath: '//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title',
)

scraped = EveryPolitician::Wikidata.morph_wikinames(source: 'tmtmtmtm/denmark-folketing-wp', column: 'wikiname')
category = WikiData::Category.new( "Kategori:Folketingsmedlemmer i 2010'erne", 'da').member_titles

sparq = 'SELECT ?item WHERE { ?item wdt:P39 wd:Q12311817 . }'
p39s  = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s, names: { da: wp2015 | wp2011 | scraped | category })
