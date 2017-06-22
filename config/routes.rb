Rails.application.routes.draw do

  get 'concerts/new'

  get 'concerts/create'

  get 'concerts/update'

  get 'concerts/edit'

  get 'concerts/destroy'

  get 'concerts/index'

  get 'concerts/show'

  get 'reservations/basket', to: 'reservations#basket'

  resources :reservations

  resources :seats do
  	resources :reservations
  end

  resources :concerts do
  	resources :reservations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
