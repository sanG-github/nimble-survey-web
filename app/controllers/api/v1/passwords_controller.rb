# frozen_string_literal: true

module API
  module V1
    class PasswordsController < Devise::PasswordsController
      include API::V1::OauthApplicationVerifiable

      def create
        super do
          render json: {
            meta: { message: t('devise.passwords.send_paranoid_instructions') }
          }

          # Skip other stuff from devise
          return
        end
      end
    end
  end
end
