# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenapiController, type: :request do
  describe 'GET#show' do
    context 'given an request' do
      it 'returns success status' do
        get :show

        expect(response).to have_http_status(:success)
      end
    end
  end
end
