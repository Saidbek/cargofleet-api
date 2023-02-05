Rails.application.routes.draw do
  root 'status#index'

  namespace :api do
    scope "/(:team_name)" do
      resources :dashboard, only: [:index]
      resources :drivers
      resources :vehicles do
        member do
          post :assign
          post :unassign
        end
      end
      resources :issues
    end
  end
end
