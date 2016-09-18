Rails.application.routes.draw do
  # root
  root :to => 'pages#show', :defaults => {:path => 'home'}

  # Admin user management routes
  get 'admin' => 'admin#admin'
  post 'login' => 'admin#login'
  get 'logout' => 'admin#logout'

  # posts
  resources :posts

  # Pages routes
  get 'pages/new' => 'pages#new'
  resources :pages, :only => [:create, :update, :destroy]
  get ':path' => 'pages#show', :as => 'page_view'
  get ':path/edit' => 'pages#edit'
  get 'gallery/:category' => 'pages#show', :defaults => {:path => 'gallery'}
end
