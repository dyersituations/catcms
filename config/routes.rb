Rails.application.routes.draw do
  # Loading images from PostgreSQL.
  mount PostgresqlLoStreamer::Engine => 'image/:path'
  # Page display routes.
  root :to => 'pages#show'
  # Admin routes.
  get 'login' => 'admin#login'
  post 'login_admin' => 'admin#login_admin'
  get 'admin' => 'admin#admin'
  post 'admin/save' => 'admin#save'
  get 'logout' => 'admin#logout'
  resources :posts, only: [:new, :create, :update, :destroy]
  resources :pages, only: [:show, :new, :edit, :create, :update, :destroy]
  # Post display and edit routes.
  get 'edit_posts' => 'pages#edit_posts'
  get ':path' => 'pages#show', :as => 'page_view'
  get 'gallery/:category' => 'pages#show', :defaults => { :path => 'gallery' }
end
