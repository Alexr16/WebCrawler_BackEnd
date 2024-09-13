require 'nokogiri'
require 'open-uri'

class Scraper
  HN_URL = 'https://news.ycombinator.com/'

  def self.scrape_hacker_news
    doc = Nokogiri::HTML(URI.open(HN_URL))

    entries = []
    doc.css('.athing').first(30).each_with_index do |entry, index|
      title = entry.css('.titleline a').text.strip
      subtext = entry.next_element.css('.subtext')
      points = subtext.css('.score').text.to_i
      comments = subtext.css('a').last.text.split.first.to_i

      entries << { number: index + 1, title: title, points: points, comments: comments }
   
    end

    entries
  end
end

# Execute the scraper and print the results
Scraper.scrape_hacker_news.each do |entry|
  puts "Title: #{entry[:title]}, Points: #{entry[:points]}, Comments: #{entry[:comments]}"
end