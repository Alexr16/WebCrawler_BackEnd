module Api
  class EntriesController < ApplicationController
    def scrape
      entries = CrawlerService.scrape_news
      CrawlerService.save_entries(entries)

      render json: { message: 'Data scraped and saved!' }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end

    def index
      filter = params[:filter]
      entries = if filter == 'moreThanFiveWords'
                  Entry.where("LENGTH(REGEXP_REPLACE(title, '[^a-zA-Z\\s]', '', 'g')) - LENGTH(REPLACE(REGEXP_REPLACE(title, '[^a-zA-Z\\s]', '', 'g'), ' ', '')) + 1 > 5").order(comments: :desc)
                elsif filter == 'lessThanOrEqualToFiveWords'
                  Entry.where("LENGTH(REGEXP_REPLACE(title, '[^a-zA-Z\\s]', '', 'g')) - LENGTH(REPLACE(REGEXP_REPLACE(title, '[^a-zA-Z\\s]', '', 'g'), ' ', '')) + 1 <= 5").order(points: :desc)
                else
                  Entry.all
                end

      UserInteraction.create(filter_type: filter || 'all', request_on: Time.current)

      render json: entries, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
    
  end
end