Rails.application.routes.draw do
  root 'status#index'

  scope "/(:team_name)" do
    namespace :api do
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
