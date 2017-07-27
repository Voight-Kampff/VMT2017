Rails.application.routes.draw do

  devise_for :users
  get 'invitation/new'

  get 'invitation/create'

  get 'invitation/show'

  root to: 'concerts#index' 

  get 'concerts/new'

  get 'concerts/create'

  get 'concerts/update'

  get 'concerts/edit'

  get 'concerts/destroy'

  get 'concerts/index'

  get 'concerts/show'

  get 'merci', to: 'orders#success'

  get 'paiement', to: 'orders#paymentform'

  post 'orders/charge', to: 'orders#charge'

  post 'orders/invitationdelivery', to: 'orders#invitationdelivery'

  post 'orders/:id/hold', to: 'orders#hold'

  get 'reservations/basket', to: 'reservations#basket'

  post 'concerts/:id/reservations/unnumbered', to: 'reservations#unnumbered'

  delete 'delete_by_seat_id', to: 'reservations#delete_by_seat_id'


  resources :orders

  resources :invitations, param: :slug

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
