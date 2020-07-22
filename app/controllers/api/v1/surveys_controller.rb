# frozen_string_literal: true

module API
  module V1
    class SurveysController < ApplicationController
      def index
        render json: Survey.all
      end
    end
  end
end
