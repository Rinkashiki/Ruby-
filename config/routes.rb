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
  resources :clips, only: [ :new, :create, :index, :show, :edit, :update, :destroy]

  get 'clips/:id/add_topic', to: 'clips#add_topic', as: 'add_topic'

  get 'clips/:id/add_topic_post', to: 'clips#add_topic_post', as: 'add_topic_post'

  get 'clips/:id/quit_topic', to: 'clips#quit_topic', as: 'quit_topic'

  get 'clips/:id/quit_question', to: 'clips#quit_question', as: 'quit_question'

  # Routes for topics
  resources :topics, only: [ :new, :create, :index, :edit, :update, :show, :destroy]

  # Routes for decisions
  resources :decisions, only: [ :index]

  # Routes for sanctions
  resources :sanctions, only: [ :index]

  # Routes for activities
  resources :activities, only: [ :index, :new, :create, :edit, :update, :show, :destroy]

  get 'activities/:id/quit_activity_question', to: 'activities#quit_activity_question', as: 'quit_activity_question'

  # Routes for questions
  resources :questions, only: [:index, :new, :create, :show]

  get 'questions/:id/add_activity_question', to: 'questions#add_activity_question', as: 'add_activity_question'

  # Routes for answers
  resources :answers, only: [:index, :new, :create, :show, :destroy]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
