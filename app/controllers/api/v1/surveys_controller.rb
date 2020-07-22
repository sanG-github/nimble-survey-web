# frozen_string_literal: true

module API
  module V1
    class SurveysController < ApplicationController
      include Pagy::Backend

      def index
        _pagy, items = pagy_array(Survey.all, pagination_params)

        render json: items
      end

      private

      def pagination_params
        {
          page: params[:page],
          items: params[:items]
        }
      end
    end
  end
end
