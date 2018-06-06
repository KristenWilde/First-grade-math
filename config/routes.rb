Rails.application.routes.draw do
  root 'pages#main'

  get '/user/new', to: 'users#new'
  get '/validate_username', to: 'users#available'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  patch '/users/:username', to: 'users#update'

  get '/:username', to: 'users#show', as: 'user'
  resources 'user'

  match "*path", to: "pages#main", via: :all

end
