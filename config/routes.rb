Myinfo::Application.routes.draw do

  root :to => 'dashboard#index'

  devise_for :users, :controllers => { :sessions => 'local_devise/sessions',
                                       :registrations => 'local_devise/registrations',
                                       :passwords => 'local_devise/passwords',
                                       :omniauth_callbacks => 'local_devise/omniauth_callbacks'}
  devise_scope :users do
    get '/users', :to => 'dashboard#index', :as => :user_root
  end

  match '/admin' => 'admin#index'
  match '/dashboard' => 'dashboard#index'
  match '/messages' => 'messages#index'
  match '/help' => 'help#index'

  match '/admin/add_new_user' => 'admin#add_new_user', :as => :add_new_user
  match '/admin/:id/update_user' => 'admin#update_user', :as => :update_user
  match '/admin/:id/delete_user' => 'admin#delete_user', :as => :delete_user

  match '/facebox/fb_edit_user' => 'facebox#fb_edit_user', :as => :fb_edit_user
  match '/facebox/fb_create_user' => 'facebox#fb_create_user', :as => :fb_create_user
  match '/facebox/fb_login' => 'facebox#fb_login', :as => :fb_login
  match '/facebox/fb_reset_password' => 'facebox#fb_reset_password', :as => :fb_reset_password


  resources :pictures, only: [:create, :destroy]
  match 'pictures/list', :controller => 'pictures', :action => 'list'
  match 'pictures',      :controller => 'pictures', :action => 'new'

  match '*not_found' => 'application#render_404'
end
