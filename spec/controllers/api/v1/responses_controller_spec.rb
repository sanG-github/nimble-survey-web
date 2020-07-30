# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::ResponsesController, type: :controller do
  describe 'POST#create', auth: :user_token do
    context 'given a valid survey ID' do
      it 'returns created status' do
        questions_ids = [
          { id: '940d229e4cd87cd1e202' },
          { id: 'c3a9b8ce5c2356010703' }
        ]
        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', response: { questions: questions_ids } }

        expect(response).to have_http_status(:created)
      end
    end

    context 'given an invalid survey ID' do
      it 'returns unprocessable_entity status' do
        questions_ids = [
          { id: '940d229e4cd87cd1e202' },
          { id: 'c3a9b8ce5c2356010703' }
        ]
        post :create, params: { survey_id: 'invalid', response: { questions: questions_ids } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'has errors' do
        post :create, params: { survey_id: 'invalid', response: { questions: [] } }

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:errors]).to include(detail: "Survey is invalid and Questions can't be blank")
      end
    end
  end
end
