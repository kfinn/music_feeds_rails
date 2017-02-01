Rails.application.routes.draw do
  resources :songs, only: :index
  resources :feed_updates, only: :create
end
