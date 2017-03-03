Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  get '/users/auth/spotify/ios_callback' => redirect('/')
  root to: 'homes#show', format: 'html'

  resource :home, only: :show
  resources :songs, only: [:show, :index]
  resources :recommendations, only: [:show, :index]
  resources :feeds, only: [:index, :show] do
    resources :updates, only: [:create]
  end
  resources :updates, only: [:show]
  resources :all_feed_updates, only: :create
  resource :me, only: :show
  resources :playlists, only: [:index, :show, :new, :create] do
    resource :spotify_sync, only: :create
  end
  resources :spotify_syncs, only: :show
end
