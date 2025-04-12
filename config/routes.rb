Rails.application.routes.draw do
  root "static_pages#top"

  get "terms_of_use", to: "static_pages#terms_of_use"
  get "privacy_policy", to: "static_pages#privacy_policy"

  get "up" => "rails/health#show", as: :rails_health_check
  
  resource :users, only: %i[show] do
    collection do
      get "profile", to: "users#profile"
      get "profile/my_reviews", to: "users#my_reviews"
      get "profile/my_instruments", to: "users#my_instruments"
    end
  end

  get "images/ogp", to: "images#ogp", as: "images_ogp"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # 地図検索ページのルーティング
  get "spots/map"
  resources :spots do
    resources :bookmarks, only: %i[create destroy]
    resources :reviews, only: %i[create destroy]
    collection do
      get :bookmarks
      get :autocomplete
    end
  end

  resources :bookmarks, only: %i[create destroy]

  resources :instruments, only: %i[index new create edit update destroy] do
    resources :likes, only: %i[create destroy]
    collection do
      get :likes
    end
  end

  resources :likes, only: %i[create destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
