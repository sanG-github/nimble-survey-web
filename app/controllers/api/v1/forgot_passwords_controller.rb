# frozen_string_literal: true

module API
  module V1
    class ForgotPasswordsController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      before_action :set_resource

      def create
        if @user.persisted?
          @user.send_reset_password_instructions

          render status: :created
        else
          @user.errors.add(:email, :blank)

          render json: { error: @user.errors.full_messages.to_sentence }, status: :not_found
        end
      end

      private

      def create_params
        params.permit(:email)
      end

      def set_resource
        @user = User.find_or_initialize_by(email: create_params[:email])
      end
    end
  end
end
