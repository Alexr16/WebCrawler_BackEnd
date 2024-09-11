module Api
  class EntriesController < ApplicationController
    def scrape
      entries = CrawlerService.scrape_hacker_news
      CrawlerService.save_entries(entries)

      render json: { message: 'Data scraped and saved!' }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    
  end
end