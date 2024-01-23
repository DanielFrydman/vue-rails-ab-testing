# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :v1 do
    post '/track_page_view', to: 'track_page_view#create'
    post '/track_event', to: 'track_event#create'
    get '/tracking_dashboard', to: 'tracking_dashboard#index'
    get '/list_event_names', to: 'tracking_dashboard#list_event_names'
  end
end
