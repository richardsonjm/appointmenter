Rails.application.routes.draw do
  devise_for :users
  root 'patients#index'

  resources :specialties
  resources :ailments
  resources :doctors
  resources :patients do
    resources :appointments, only: [:create]
  end
  resources :appointments, only: [:index, :show, :update, :destroy]
end
