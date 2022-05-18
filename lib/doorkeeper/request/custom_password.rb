# frozen_string_literal: true

require 'doorkeeper/oauth/custom_password_access_token_request'

module Doorkeeper
  module Request
    class CustomPassword < Password
      def request
        @request ||= OAuth::CustomPasswordAccessTokenRequest.new(
          Doorkeeper.configuration,
          client,
          credentials,
          resource_owner,
          parameters
        )
      end
    end
  end
end
