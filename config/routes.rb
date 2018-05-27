Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#main'

  get '/user/new', to: 'users#new'
  get '/validate_username', to: 'users#validate'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  patch '/users/:username', to: 'users#update'

  get '/:username', to: 'users#show'

  match "*path", to: "pages#main", via: :all

end
