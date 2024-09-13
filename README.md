# Web Crawler (Backend - Ruby on Rails)

## Description
This API scrapes entries from Hacker News and provides endpoints to fetch and filter these entries.
The endpoints will be use in the Frontend part of these project.

[Frontend Repository](https://github.com/Alexr16/WebCrawler_FrontEnd)

## Technologies
- **Backend**: Ruby on Rails, PostgreSQL, Nokogiri (scraping)
- **Testing**: RSpec for Rails
- **Documentation**: Swagger
  
## Endpoints

- **GET** `/api/scrape`: Scrapes the first 30 entries from [Hacker News](https://news.ycombinator.com/) and stores them in the database.
- **GET** `/api/entries?filter=<filter>`: Fetches entries from the database. You can filter the results with:
  - `moreThanFiveWords`: Filters entries with titles longer than five words.
  - `lessThanOrEqualToFiveWords`: Filters entries with titles containing five words or fewer.

## API Documentation

You can access the API documentation and try out the endpoints using **Swagger**: http://localhost:3000/api-docs

This will open the Swagger UI where you can interact with the API and see detailed documentation for each endpoint.

## Running the Application

To set up the application:

1. Clone the repository:

    ```bash
    git clone https://github.com/Alexr16/WebCrawler_BackEnd.git
    cd WebCrawler_BackEnd
    ```

2. Install dependencies:

    ```bash
    bundle install
    ```

3. Set up the database:

    ```bash
    rails db:create
    rails db:migrate
    ```

4. Start the Rails server:

    ```bash
    rails s
    ```

5. Navigate to [http://localhost:3000/api-docs](http://localhost:3000/api-docs) to view and interact with the Swagger documentation.