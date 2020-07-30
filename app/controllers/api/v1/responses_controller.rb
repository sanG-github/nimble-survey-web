# frozen_string_literal: true

module API
  module V1
    class ResponsesController < ApplicationController
      def create
        response_form = ResponseForm.new(create_params)

        if response_form.save
          render status: :created
        else
          render_error(detail: response_form.errors.full_messages.to_sentence)
        end
      end

      private

      def create_params
        params
          .require(:response)
          .permit(questions: [:id, { answers: %i[id answer] }])
          .to_h
          .merge(survey_id: params[:survey_id])
      end
    end
  end
end
