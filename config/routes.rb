Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, path: 'auth', path_names: {dang_nhap: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in'}
  root to: 'home#index'

  devise_scope :user do
    get 'dang_nhap', to: 'devise/sessions#new'
  end

  get '/quan-ly-nguoi-dung', to: 'admin#index'
  get '/quan-ly-nhom-nguoi-dung', to: 'group#index'
  post 'add-user', to: 'admin#add_user'

  get '/groups/new', to: 'group#new'
  post '/groups/new', to: 'group#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
