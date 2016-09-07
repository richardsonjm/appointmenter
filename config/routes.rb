Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :specialties
  resources :ailments
  resources :doctors
  resources :users, except: [:new, :create] do
    post :confirm_doctor
  end
  resources :appointments, only: [:index, :show, :create, :update, :destroy]
end
