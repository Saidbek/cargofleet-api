Rails.application.routes.draw do
  apipie

  root 'status#index'

  scope "/(:team_name)" do
    namespace :api do
      resources :drivers do
        resources :trips do
          member do
            put :complete
          end
        end
      end
      resources :vehicles do
        resources :issues
      end
    end
  end
end
