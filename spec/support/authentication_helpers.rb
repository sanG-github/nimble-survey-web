# frozen_string_literal: true

RSpec.configure do |config|
  # For user authentication
  config.before(:example, auth: :user_token) do
    user = Fabricate(:user)
    application = Fabricate(:application)
    access_token = Fabricate(:access_token, resource_owner_id: user.id, application_id: application.id)

    allow(controller).to receive(:doorkeeper_token) { access_token }
    request.headers['Content-Type'] = 'application/json'
  end

  def oauth_application_params(application = Fabricate(:application))
    {
      client_id: application.uid,
      client_secret: application.secret
    }
  end
end
