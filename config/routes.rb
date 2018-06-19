Rails.application.routes.draw do
  root 'pages#main'

  get '/validate_username', to: 'users#available'
  post '/users', to: 'users#create'
  get '/login', to: 'pages#main'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/:username', to: 'users#show', as: 'user'
  patch '/users/:username', to: 'users#update'
  get '/:username/date_records', to: 'users#date_records'

  get "*path", to: "pages#main", via: :all
end
