Rails.application.routes.draw do

  devise_for :users
  resources :charges, only: [:create]
  resources :payment_intents, only: [:create]
  root to: 'plans#index'

  get 'success', to: 'static#success'
end