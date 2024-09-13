require 'swagger_helper'

RSpec.describe 'API Entries', type: :request do
  path '/api/scrape' do
    get('scrape hacker news') do
      tags 'Entries'
      description 'Scrapes the first 30 entries from Hacker News and stores them in the database'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object, properties: {
          message: { type: :string }

          }, required: ['message']

        run_test!
      end

      
    end
  end

  path '/api/entries' do
    get('list entries') do
      tags 'Entries'
      description 'Fetches entries from the database'
      produces 'application/json'
      
      response(200, 'successful') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            points: { type: :integer },
            comments: { type: :integer }
          },
          required: ['id', 'title', 'points', 'comments']
        }

        run_test!
      end

      
    end

    get('filter entries') do
      tags 'Filter Entries'
      description 'Fetches entries from the database with optional filters'
      produces 'application/json'
      parameter filter: "lessThanOrEqualToFiveWords"
      response(200, 'successful') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            points: { type: :integer },
            comments: { type: :integer }
          },
          required: ['id', 'title', 'points', 'comments']
        }

        run_test!
      end

      
    end
  end
end