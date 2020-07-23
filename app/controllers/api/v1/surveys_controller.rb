# frozen_string_literal: true

module API
  module V1
    class SurveysController < ApplicationController
      include Pagy::Backend

      def index
        pagy, surveys = pagy_array(Survey.all, pagination_params)

        render json: SurveySerializer.new(surveys, meta: meta_from_pagy(pagy))
      rescue Pagy::OverflowError
        render status: :not_found
      end

      private

      def pagination_params
        {
          page: params.dig(:page, :number) || Pagy::VARS[:page],
          items: params.dig(:page, :size)
        }
      end

      def meta_from_pagy(pagy)
        {
          page: pagy.page,
          pages: pagy.pages,
          page_size: pagy.items,
          records: pagy.count
        }
      end
    end
  end
end
