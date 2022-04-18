Rails.application.routes.draw do
  require "sidekiq/web"

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    devise_for :users
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, only: :show
    resources :currencies, only: %i(new create index)

    namespace :admin do
      mount Sidekiq::Web => "/sidekiq"
      post "/payment", to: "payments#create"
      post "/payment_all", to: "payments#create_all"
      resources :goal_results, only: %i(create new)
      resources :user_bets, only: :index
      resources :bets
      post "/update_bets", to: "bets#update_bets"
      resources :soccer_matches
      resources :statistics, only: :index
      root to: "soccer_matches#index"
    end

    resources :bets, only: :index do
      member do
        resources :user_bets, only: %i(new create)
      end
    end
    get "/user_bets", to: "user_bets#index"
  end
end
