Rails.application.routes.draw do

  devise_for :users

  root 'home#top'
  get 'home/about'
  
  resources :books 

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
