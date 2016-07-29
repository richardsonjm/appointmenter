Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :specialties
  resources :ailments
  resources :doctors
  resources :users, except: [:new, :create]
  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
