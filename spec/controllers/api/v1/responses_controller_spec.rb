# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::ResponsesController, type: :controller do
  describe 'POST#create', auth: :user_token do
    context 'given a valid survey ID' do
      it 'returns created status' do
        questions_ids = [
          { id: '940d229e4cd87cd1e202', answers: [{ id: '037574cb93d16800eecd' }] },
          { id: 'c3a9b8ce5c2356010703', answers: [{ id: '2a49e148c5b170aca804', answer: 'My answer' }] }
        ]

        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids }

        expect(response).to have_http_status(:created)
      end
    end

    context 'given an invalid survey ID' do
      it 'returns unprocessable_entity status' do
        questions_ids = [
          { id: '940d229e4cd87cd1e202' }
        ]

        post :create, params: { survey_id: 'invalid', questions: questions_ids }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'has errors' do
        questions_ids = [
          { id: '940d229e4cd87cd1e202' }
        ]

        post :create, params: { survey_id: 'invalid', questions: questions_ids }

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:errors]).to include(detail: 'Survey is invalid')
      end
    end

    context 'given no questions' do
      it 'returns unprocessable_entity status' do
        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', questions: [] }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'has errors' do
        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', questions: [] }

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:errors]).to include(detail: "Questions can't be blank")
      end
    end

    context 'given questions with invalid question IDs' do
      it 'returns unprocessable_entity status' do
        questions_ids = [
          { id: 'invalid' }
        ]

        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'has errors' do
        questions_ids = [
          { id: 'invalid' }
        ]

        post :create, params: { survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids }

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:errors]).to include(detail: 'Questions is invalid')
      end
    end
  end
end
