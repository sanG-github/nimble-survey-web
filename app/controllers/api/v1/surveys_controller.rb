# frozen_string_literal: true

module API
  module V1
    class SurveysController < ApplicationController
      include Pagy::Backend

      def index
        pagy, surveys = pagy_array(Survey.all, pagination_params)

        render json: SurveySerializer.new(surveys, meta: meta_from_pagy(pagy))
      end

      private

      def pagination_params
        {
          page: params[:page],
          items: params[:items]
        }
      end

      def meta_from_pagy(pagy)
        {
          page: pagy.page,
          pages: pagy.pages,
          items: pagy.items,
          count: pagy.count
        }
      end
    end
  end
end
