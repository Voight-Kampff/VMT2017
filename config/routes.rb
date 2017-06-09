Rails.application.routes.draw do
  get 'orders/new'

  get 'orders/create'

  get 'orders/edit'

  get 'orders/update'

  get 'orders/delete'

  get 'orders/destroy'

  get 'seats/new'

  get 'seats/create'

  get 'seats/edit'

  get 'seats/destroy'

  get 'concerts/new'

  get 'concerts/create'

  get 'concerts/update'

  get 'concerts/edit'

  get 'concerts/destroy'

  get 'concerts/index'

  get 'concerts/show'

  resources :reservations

  resources :seats do
  	resources :reservations
  end

  resources :concerts do
  	resources :reservations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
