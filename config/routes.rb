Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'homes#show', format: 'html'

  resource :home, only: :show
  resources :songs, only: [:show, :index]
  resources :recommendations, only: [:show, :index]
  resources :feeds, only: [:index, :show] do
    resources :updates, only: [:create]
  end
  resources :all_feed_updates, only: :create
  resource :me, only: :show
  resources :playlists, only: [:index, :show, :new, :create] do
    resource :spotify_sync, only: :create
  end
end
