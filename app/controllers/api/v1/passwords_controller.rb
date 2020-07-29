# frozen_string_literal: true

module API
  module V1
    class PasswordsController < Devise::PasswordsController
      skip_before_action :verify_authenticity_token

      protected

      def respond_with(*)
        render json: {
          meta: { message: t('devise.passwords.send_paranoid_instructions') }
        }
      end
    end
  end
end
