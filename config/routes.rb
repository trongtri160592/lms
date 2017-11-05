Rails.application.routes.draw do

  # Route for commontator
  mount Commontator::Engine => '/commontator'

  devise_for :admins
  root to: 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get '/quan-ly-nguoi-dung', to: 'user#index', as: 'user'
  get '/quan-ly-nhom-nguoi-dung', to: 'group#index', as: 'group'
  post '/add-user', to: 'user#add_list'
  get '/nguoi-dung/:id/sua', to: 'user#edit', as: 'user_edit'
  patch '/nguoi-dung/:id/sua', to: 'user#update', as: 'user_update'

  get '/groups/new', to: 'group#new'
  post '/groups/new', to: 'group#create'

  get '/quan-ly-khoa-hoc', to: 'course#index', as: 'course'
  post '/courses/new', to: 'course#create', as: 'course_new'
  get '/khoa-hoc/:id/chi-tiet', to: 'course#detail', as: 'course_detail'

  get '/quan-ly-chu-de', to: 'topic#index', as: 'topic'
  post '/topics/new', to: 'topic#create', as: 'topic_new'

  get '/them-noi-dung/:course_id/:type_id', to: 'lesson#new', as: 'lesson_new'
  post '/them-noi-dung/:course_id/:type_id', to: 'lesson#create', as: 'lesson_create'
  get '/noi-dung/:id/sua', to: 'lesson#edit', as: 'lesson_edit'
  patch '/noi-dung/:id/sua', to: 'lesson#update', as: 'lesson_update'

  get '/bai-hoc/:id', to: 'lesson#show', as: 'lesson_detail'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
