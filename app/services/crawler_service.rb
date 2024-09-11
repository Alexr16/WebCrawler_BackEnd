require 'nokogiri'
require 'open-uri'

class CrawlerService
  NEWS_URL = 'https://news.ycombinator.com/'

  def self.scrape_hacker_news
    doc = Nokogiri::HTML(URI.open(NEWS_URL))
    entries = []

    doc.css('.athing').first(30).each_with_index do |entry, index|
      title = entry.css('.storylink').text
      subtext = entry.next_element.css('.subtext')
      points = subtext.css('.score').text.to_i
      comments = subtext.css('a').last.text.split.first.to_i

      entries << { number: index + 1, title: title, points: points, comments: comments }
    end

    entries
  end

  def self.save_entries(entries)
    entries.each do |entry|
      Entry.create!(
        title: entry[:title],
        points: entry[:points],
        comments: entry[:comments]
      )
    end
  end
end