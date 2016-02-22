require 'bundler'
Bundler.require

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://da.wikipedia.org/wiki/Folketingsmedlemmer_valgt_i_2015',
  xpath: '//h2/following-sibling::ul//a[contains(@href, "/wiki/") and not(@class="new")]/@title',
)

EveryPolitician::Wikidata.scrape_wikidata(names: { da: names })
warn EveryPolitician::Wikidata.notify_rebuilder
