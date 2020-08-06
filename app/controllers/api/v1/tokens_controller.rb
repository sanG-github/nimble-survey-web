# frozen_string_literal: true

module API
  module V1
    class TokensController < Doorkeeper::TokensController
      # Override Doorkeeper::TokensController#revoke to remove client credentials check
      # We didn't use any client credentials
      def revoke
        # The authorization server responds with HTTP status code 200 if the client
        # submitted an invalid token or the token has been revoked successfully.
        if token.blank?
          render json: {}
          # The authorization server validates [...] and whether the token
          # was issued to the client making the revocation request. If this
          # validation fails, the request is refused and the client is informed
          # of the error by the authorization server as described below.
        elsif authorized?
          revoke_token
          render json: {}
        else
          render json: revocation_error_response, status: :forbidden
        end
      end
    end
  end
end
