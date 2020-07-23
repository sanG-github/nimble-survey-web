# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::SurveysController do
  describe 'GET#index', auth: :user_token do
    context 'given a request without any params' do
      it 'returns success status' do
        get :index

        expect(response).to have_http_status(:success)
      end

      it 'matches json schema' do
        get :index

        response_body = JSON.parse(response.body)
        expect(response_body).to match_json_schema('v1/surveys/index/valid')
      end

      it 'returns the correct meta data' do
        get :index

        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body[:meta]).to eq(page: 1, pages: 4, page_size: 5, records: 20)
      end
    end

    context 'given a request with pagination params' do
      context 'given a valid page number' do
        it 'returns success status' do
          get :index, params: { page: { number: 2, size: 2 } }

          expect(response).to have_http_status(:success)
        end

        it 'matches json schema' do
          get :index, params: { page: { number: 2, size: 2 } }

          response_body = JSON.parse(response.body)
          expect(response_body).to match_json_schema('v1/surveys/index/valid')
        end

        it 'returns the correct meta data' do
          get :index, params: { page: { number: 2, size: 2 } }

          response_body = JSON.parse(response.body, symbolize_names: true)
          expect(response_body[:meta]).to eq(page: 2, pages: 10, page_size: 2, records: 20)
        end
      end

      context 'given an invalid page number' do
        it 'returns not_found status' do
          get :index, params: { page: { number: 100, size: 2 } }

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
