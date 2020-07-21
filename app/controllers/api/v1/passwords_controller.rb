# frozen_string_literal: true

module API
  module V1
    class PasswordsController < Devise::PasswordsController
      skip_before_action :verify_authenticity_token

      protected

      def respond_with(*resource)
        user = resource.first

        if user.blank?
          render json: {}, status: :created
        else
          render json: { error: user.errors.full_messages.to_sentence }, status: :not_found
        end
      end
    end
  end
end
