# frozen_string_literal: true

Rails.application.routes.draw do
  get 'song_opinions/new'

  get 'song_opinions/create'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users/auth/spotify/ios_callback' => redirect('/')
  root to: 'songs#index', format: 'html'

  resource :home, only: :show
  resources :songs, only: %i[show index edit update] do
    resources :spotify_id_corrections, only: %i[new create]
    resource :song_opinion, only: :create
  end
  resources :recommendations, only: %i[show index]
  resources :feeds, only: %i[index show] do
    resources :updates, only: :create
  end
  resources :updates, only: :show
  resource :me, only: :show
  resources :playlists, only: %i[index show new create] do
    resource :spotify_sync, only: :create
  end
  resources :spotify_syncs, only: :show
end
