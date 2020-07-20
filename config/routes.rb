Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#edit"
  end

  scope 'api/v1' do
    use_doorkeeper do
      skip_controllers :applications, :authorizations, :token_info
    end
  end

  namespace :api do
    namespace :v1 do
      resource :forgot_password, only: :create
    end
  end
end
