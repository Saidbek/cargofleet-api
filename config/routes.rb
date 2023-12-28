Rails.application.routes.draw do
  apipie

  root 'status#index'

  scope "/(:team_name)" do
    namespace :api do
      resources :dashboard, only: [:index]
      resources :drivers
      resources :vehicles do
        resources :issues
        resources :trips
      end
    end
  end
end
