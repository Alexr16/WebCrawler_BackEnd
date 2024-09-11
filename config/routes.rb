Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    get 'scrape', to: 'entries#scrape'
    get 'entries', to: 'entries#index'
  end

end
