# frozen_string_literal: true

module API
  module V1
    class ApplicationController < ActionController::API
      before_action :doorkeeper_authorize!

      private

      # Render Error Message in json_api format
      # :reek:LongParameterList { max_params: 5 }
      def render_error(detail:, source: nil, meta: nil, status: :unprocessable_entity, code: nil)
        errors = [
          {
            source: source,
            detail: detail,
            code: code,
            meta: meta
          }.compact
        ]

        render json: { errors: errors }, status: status
      end

      def verify_oauth_application
        return if Doorkeeper::Server.new(self).client

        error_description = I18n.t('doorkeeper.errors.messages.invalid_client')
        render_error(detail: error_description, code: :invalid_client, status: :forbidden)
      end

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
