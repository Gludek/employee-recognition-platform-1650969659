# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :employees, path: 'employees'
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    resources :kudos
    resources :employees, except: :create do
      member do
        resources :orders, only: %i[index show] , as: 'employee_orders'
      end
    end
    resources :rewards
    resources :company_values
    
    root to: 'pages#dashboard'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: "employees" do
    resources :kudos
  resources :rewards, only: %i[index show]
  resources :orders, only: %i[new create] 
  resources :employees do
    member do
      resources :orders, only: %i[index show]
      get "orders", to: "order#index"
    end
  end
  root to: 'kudos#index'
end
end
