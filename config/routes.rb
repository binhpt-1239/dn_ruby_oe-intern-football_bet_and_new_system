Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :users, only: :show
    resources :currencies, only: %i(new create index)
    resources :bets, only: :index

    namespace :admin do
      resources :bets
      resources :soccer_matches
      root to: "soccer_matches#index"
    end
  end
end
