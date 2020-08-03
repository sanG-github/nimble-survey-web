# frozen_string_literal: true

module API
  module V1
    class UsersController < ApplicationController
      def show
        render json: current_user
      end
    end
  end
end
