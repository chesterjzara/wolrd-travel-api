Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # User Routes
  get '/users', to: 'users#index'
	get '/users/:id', to:'users#show'
	post '/users', to: 'users#create'
	delete '/users/:id', to: 'users#delete'
	put '/users/:id', to: 'users#update'

  # Countries Routes
  get '/countries', to: 'countries#index'
  get '/countries/:id', to: 'countries#show'
  get '/countries/user/:userid/', to: 'countries#showByUser'
    # Note - finds all user_country rows for a given user id
  post '/countries/', to: 'countries#create'
    # Note - expects body to contain the user_id for this trip
  delete '/countries/:id/', to: 'countries#delete'
  put '/countries/:id/', to: 'countries#update'

end
