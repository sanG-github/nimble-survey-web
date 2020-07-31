Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#edit"
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        controllers tokens: 'api/v1/tokens'
        skip_controllers :applications, :authorizations, :token_info
      end
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :passwords, only: :create
      end

      resources :surveys, only: %i[index show]
    end
  end
end
