Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
}
  resource :users, only: %i[show] do
    collection do
      get 'profile', to: 'users#profile'
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#top"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # 地図検索ページのルーティング
  get "spots/map"
  # 施設情報とブックマークしている施設情報を一覧表示するためのルーティング
  resources :spots do
    # ブックマークつけたり外したりするためのルーティング
    resources :bookmarks, only: %i[create destroy]
    collection do
      get :bookmarks
    end
  end

  resources :bookmarks, only: %i[create destroy]
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
