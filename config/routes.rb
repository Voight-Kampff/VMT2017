Rails.application.routes.draw do

  root to: 'concerts#index' 

  get 'concerts/new'

  get 'concerts/create'

  get 'concerts/update'

  get 'concerts/edit'

  get 'concerts/destroy'

  get 'concerts/index'

  get 'concerts/show'

  get 'reservations/basket', to: 'reservations#basket'

  post 'concerts/:id/reservations/unnumbered', to: 'reservations#unnumbered'


  resources :orders

  resources :charges

  resources :concerts

  resources :reservations

  resources :seats do
  	resources :reservations
  end

  resources :concerts do
  	resources :reservations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
