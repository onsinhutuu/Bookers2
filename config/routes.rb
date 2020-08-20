Rails.application.routes.draw do
  get '/home/about' => 'books#about'
  get  root "users#top"
  devise_for :users
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update,:index, :top]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
