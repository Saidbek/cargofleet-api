Rails.application.routes.draw do
  root 'status#index'

  namespace :api do
    resources :drivers
    resources :issues
    resources :vehicles
  end
end
