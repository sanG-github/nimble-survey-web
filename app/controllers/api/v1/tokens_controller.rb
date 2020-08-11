# frozen_string_literal: true

module API
  module V1
    class TokensController < Doorkeeper::TokensController
      private

      def revocation_error_response
        {
          errors: [
            {
              detail: I18n.t('doorkeeper.errors.messages.revoke.unauthorized'),
              code: :unauthorized_client
            }.compact
          ]
        }
      end
    end
  end
end
