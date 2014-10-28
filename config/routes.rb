Rails.application.routes.draw do

root 'qing#index'

get '/yelp' => 'yelp#coords'

resources :users, only: [:new, :create]
resources :sessions, only: [:create, :destroy]
match '/signout', to: 'sessions#destroy', via: 'delete'
match '/signin', to: 'sessions#create', via: 'post'
get '/logout' => 'sessions#destroy'

resources :locations, only: [:create] do
  resources :duration, only: [:new, :show, :create]
end

  get '/loadpins.json' => 'locations#load_pins'
  post 'locations/categories' => 'locations#update_categories'
  post '/locations/update' => 'locations#update_geo'

end