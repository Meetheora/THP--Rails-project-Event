Rails.application.routes.draw do
  root "events#index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  devise_for :users

  resources :events do
    resources :attendances, only: [:new, :create, :index]
  end
  resources :users, only: [:show] do
    resources :avatars, only: [:create]
  end

  namespace :admin do
    get "event_submissions/index"
    get "event_submissions/show"
    get "event_submissions/edit"
    get "event_submissions/update"
    get "dashboard/index"
    root "dashboard#index"
    resources :users
    resources :events
    resources :event_submissions, only: [:index, :show, :edit, :update]
  end
end