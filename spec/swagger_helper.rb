require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {
        '/api/scrape' => {
          get: {
            tags: ['Entries'],
            summary: 'Scrape Hacker News',
            description: 'Scrapes the first 30 entries from Hacker News and stores them in the database',
            responses: {
              '200': {
                description: 'Data scraped and saved successfully',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        message: { type: 'string' }
                      },
                      required: ['message']
                    }
                  }
                }
              },
              '500': {
                description: 'Internal server error',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error: { type: 'string' }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        },
        '/api/entries' => {
          get: {
            tags: ['Entries'],
            summary: 'List Entries',
            description: 'Fetches entries from the database with optional filters',
            parameters: [
              {
                name: 'filter',
                in: 'query',
                description: 'Filter entries by word count in the title',
                schema: {
                  type: 'string',
                  enum: ['moreThanFiveWords', 'lessThanOrEqualToFiveWords']
                }
              }
            ],
            responses: {
              '200': {
                description: 'Successful response',
                content: {
                  'application/json': {
                    schema: {
                      type: 'array',
                      items: {
                        type: 'object',
                        properties: {
                          id: { type: 'integer' },
                          title: { type: 'string' },
                          points: { type: 'integer' },
                          comments: { type: 'integer' }
                        },
                        required: ['id', 'title', 'points', 'comments']
                      }
                    }
                  }
                }
              },
              '500': {
                description: 'Internal server error',
                content: {
                  'application/json': {
                    schema: {
                      type: 'object',
                      properties: {
                        error: { type: 'string' }
                      },
                      required: ['error']
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end