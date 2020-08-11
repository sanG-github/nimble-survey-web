# frozen_string_literal: true

module API
  module V1
    class RegistrationsController < ApplicationController
      before_action :verify_oauth_application
      skip_before_action :doorkeeper_authorize!

      def create
        user = User.new(create_params)

        if user.save
          head :created
        else
          render_error(detail: user.errors.full_messages.to_sentence)
        end
      end

      private

      def create_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
