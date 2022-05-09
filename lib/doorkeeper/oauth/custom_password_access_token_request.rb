# frozen_string_literal: true

module Doorkeeper
  module OAuth
    class CustomPasswordAccessTokenRequest < PasswordAccessTokenRequest
      validate :client, error: :invalid_client
      validate :resource_owner, error: :invalid_email_or_password
      validate :password, error: :invalid_email_or_password

      private

      def validate_client
        client.present?
      end

      def validate_password
        is_valid_password = resource_owner.valid_password?(parameters[:password])
        return true if is_valid_password

        # Use the Devise Lockable method to increase the failed_attempts
        resource_owner.valid_for_authentication? { is_valid_password }
      end
    end
  end
end
