Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get "home/about" => "home#about", as: "about"
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
end
