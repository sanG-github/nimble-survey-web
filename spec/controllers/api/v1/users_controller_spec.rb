# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::UsersController do
  describe 'GET#show', auth: :user_token do
    it 'returns success status' do
      get :show

      expect(response).to have_http_status(:success)
    end

    it 'matches json schema' do
      get :show

      response_body = JSON.parse(response.body)
      expect(response_body).to match_json_schema('v1/users/show/valid')
    end
  end
end
