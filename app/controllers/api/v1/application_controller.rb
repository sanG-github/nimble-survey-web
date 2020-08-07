# frozen_string_literal: true

module API
  module V1
    class ApplicationController < ActionController::API
      before_action :doorkeeper_authorize!

      private

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

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
    end
  end
end
