# frozen_string_literal: true

module API
  module V1
    class ResponsesController < ApplicationController
      def create
        response_form = ResponseForm.new(create_params.to_h)

        if response_form.save
          render json: {}, status: :created
        else
          render_error(detail: response_form.errors.full_messages.to_sentence)
        end
      end

      private

      def create_params
        params
          .require(:response)
          .permit(:survey_id, questions: [:id, { answers: %i[id answer] }])
      end
    end
  end
end
