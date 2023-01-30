Rails.application.routes.draw do
  root 'status#index'

  namespace :api do
    resources :dashboard, only: [:index]
    resources :drivers
    resources :issues
    resources :vehicles do
      member do
        post :assign
        post :unassign
      end
    end
  end
end
