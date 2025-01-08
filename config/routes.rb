Rails.application.routes.draw do
  apipie

  root 'status#index'

  scope "/(:team_name)" do
    namespace :api do
      resources :dashboard, only: [:index]
      resources :drivers do
        resources :trips do
          member do
            patch :complete
            patch :uncomplete
          end
        end
      end
      resources :vehicles do
        resources :issues do
          patch :complete
          patch :uncomplete
        end
      end
    end
  end
end
