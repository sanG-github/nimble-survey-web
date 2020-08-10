Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#edit"
  end

  use_doorkeeper do
    skip_controllers :tokens, :authorizations, :token_info, :authorized_applications
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :applications, :authorizations, :token_info, :authorized_applications
      end
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :passwords, only: :create
      end

      resources :responses, only: :create
      resources :surveys, only: %i[index show]
      resource :users, only: :show, path: :me
    end
  end
end
