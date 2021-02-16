Rails.application.routes.draw do

  root to: 'session#welcome'

  # Routes for session
  get 'login', to: 'session#new'

  post 'login', to: 'session#create'

  get 'welcome', to: 'session#welcome'

  get 'index', to: 'session#index'

  #resources :images

  # Routes for users 
  resources :users, only: [ :new, :create, :index, :edit, :update, :show, :destroy]

  # Routes for clips
  resources :clips, only: [ :new, :create, :index, :show, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
