# frozen_string_literal: true

module API
  module V1
    class ApplicationController < ActionController::API
      before_action :doorkeeper_authorize!

      private

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
