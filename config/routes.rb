Rails.application.routes.draw do
  # Root loads first page
  root :to => 'pages#show'

  # Admin routes
  get 'login' => 'admin#login'
  post 'login_admin' => 'admin#login_admin'
  get 'admin' => 'admin#admin'
  post 'admin/save' => 'admin#save'
  get 'logout' => 'admin#logout'

  resources :posts

  get 'pages/new' => 'pages#new'
  resources :pages, :only => [:create, :update, :destroy]
  get ':path' => 'pages#show', :as => 'page_view'
  get ':path/edit' => 'pages#edit'
  get 'gallery/:category' => 'pages#show', :defaults => {:path => 'gallery'}
end
