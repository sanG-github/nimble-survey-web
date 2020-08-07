# frozen_string_literal: true

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view

  # Every time you want to unit test a devise controller,
  # you need to tell Devise which mapping to use.
  # We need this because ActionController::TestCase and spec/controllers bypass the router
  # and it is the router that tells Devise which resource is currently being accessed
  config.before(:each, devise_mapping: true) do |example|
    example.metadata[:devise_mapping] = :user if example.metadata[:devise_mapping] == true

    request.env['devise.mapping'] = Devise.mappings[example.metadata[:devise_mapping]]
  end
end
