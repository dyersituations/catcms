Rails.application.routes.draw do
  # Loading images from PostgreSQL.
  mount PostgresqlLoStreamer::Engine => "/page_banner"
  # Page display routes.
  root :to => 'pages#show'
  # Admin routes.
  get 'login' => 'admin#login'
  post 'login_admin' => 'admin#login_admin'
  get 'admin' => 'admin#admin'
  post 'admin/save' => 'admin#save'
  get 'logout' => 'admin#logout'
  # Default post and page routes.
  resources :posts
  resources :pages
  # Post display and edit routes.
  get 'edit_posts' => 'pages#edit_posts'
  get ':path' => 'pages#show', :as => 'page_view'
  get 'gallery/:category' => 'pages#show', :defaults => { :path => 'gallery' }
end
