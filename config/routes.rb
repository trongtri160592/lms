Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, path: 'auth', path_names: {dang_nhap: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'}
  root to: 'home#index'

  devise_scope :user do
    get 'dang_nhap', to: 'devise/sessions#new'
  end

  get '/quan-ly-nguoi-dung', to: 'user#index'
  get '/quan-ly-nhom-nguoi-dung', to: 'group#index'
  post 'add-user', to: 'user#add_user'
  get '/nguoi-dung/:id/sua', to: 'user#edit', as: 'user_edit'
  patch '/nguoi-dung/:id/sua', to: 'user#update', as: 'user_update'

  get '/groups/new', to: 'group#new'
  post '/groups/new', to: 'group#create'

  get '/quan-ly-chu-de', to: 'topic#index', as: 'topic'
  post '/topics/new', to: 'topic#create', as: 'topic_new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
