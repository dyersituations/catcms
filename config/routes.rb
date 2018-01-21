Rails.application.routes.draw do
  root :to => 'pages#show'
  get 'login' => 'admin#login'
  post 'login_admin' => 'admin#login_admin'
  get 'admin' => 'admin#admin'
  post 'admin/save' => 'admin#save'
  get 'logout' => 'admin#logout'
  resources :posts
  resources :pages
  get ':path' => 'pages#show', :as => 'page_view'
  get ':path/edit' => 'pages#edit'
  get 'gallery/:category' => 'pages#show', :defaults => {:path => 'gallery'}
end
