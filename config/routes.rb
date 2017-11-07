Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index, :zomg]
  resources :movies, only: [:index, :show, :create]
  # resources :zomg, only: [:index]


  post '/check-out', to: 'rentals#check_out'
  # post '/check-in', to: 'rentals#check-in'
end
