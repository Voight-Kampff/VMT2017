Rails.application.routes.draw do

  #Websockets
  mount ActionCable.server => '/cable'
  #resources :reservations, param: :slug

  devise_for :users
  
  get 'invitation/new'

  get 'invitation/create'

  get 'invitation/show'

  root to: 'concerts#index' 

  get 'merci', to: 'orders#success'

  get 'paiement', to: 'orders#paymentform'

  post 'orders/charge', to: 'orders#charge'

  post 'orders/invitationdelivery', to: 'orders#invitationdelivery'

  post 'orders/:id/hold', to: 'orders#hold'

  get 'reservations/basket', to: 'reservations#basket'

  post 'concerts/:id/reservations/unnumbered', to: 'reservations#unnumbered'

  delete 'delete_by_seat_id', to: 'reservations#delete_by_seat_id'

  get 'dashboards', to: 'dashboards#index'

  get 'dashboards/concerts/:id', to: 'dashboards#show'

  get '.well-known/acme-challenge/G9w9_Y8mdSmC3HahDKs8J620nPih9_pdyA6IDKUYex8', to: 'dashboards#G9w9_Y8mdSmC3HahDKs8J620nPih9_pdyA6IDKUYex8'

  get 'api/reservations/:id/:code', to: 'api#scan'
  get 'api/orders/:id/:code', to: 'api#scan_order'
  get 'api/seatcodes/:id/:code', to: 'api#scan_seat_code'


  ##split controllers, correct method
  namespace :payments do
    resource :cashierpayments, only: [:create]
  end

  resources :invitations, param: :slug

  namespace :admin do
    resource :tags
    resource :bvrs
  end

  resources :orders, only: [:show,:update]

  resources :charges

  resources :concerts

  resources :reservations

  resources :seats do
  	resources :reservations
  end

  resources :concerts do
  	resources :reservations
  end

  #Auth0 routes
  get 'auth/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
