Rails.application.routes.draw do
  root :to => 'pages#show', 'path' => 'home'

  get 'admin' => 'admin#admin'
  post 'admin/save' => 'admin#save'
  post 'login' => 'admin#login'
  get 'logout' => 'admin#logout'

  resources :posts

  post 'pages/new' => 'pages#new'
  resources :pages, :only => [:create, :update, :destroy]
  get ':path' => 'pages#show', :as => 'page_view'
  get ':path/edit' => 'pages#edit'
  get 'gallery/:category' => 'pages#show', :defaults => {:path => 'gallery'}
end
