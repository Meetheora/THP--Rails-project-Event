Rails.application.routes.draw do
  root "events#index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  devise_for :users

  resources :events
  resources :users, only: [:show]
end