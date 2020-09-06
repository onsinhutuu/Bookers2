Rails.application.routes.draw do
  get '/home/about' => 'books#about'
  get  root "users#top"
  devise_for :users
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update,:index, :top] do
  	 member do
     get :following, :followers
     end
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
