# frozen_string_literal: true

module API
  module V1
    class PasswordsController < ApplicationController
      before_action :verify_oauth_application
      skip_before_action :doorkeeper_authorize!

      def create
        User.send_reset_password_instructions(create_params)

        render json: {
          meta: { message: I18n.t('devise.passwords.send_paranoid_instructions') }
        }
      end

      private

      def create_params
        params.permit(:email)
      end
    end
  end
end
