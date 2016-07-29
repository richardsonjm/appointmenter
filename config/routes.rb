Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, expect: [:new, :create]
  resources :specialties
  resources :ailments
  resources :doctors
  resources :users
  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
