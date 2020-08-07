# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::TokensController, type: :controller do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:doorkeeper_authorize!) }
  end

  describe 'POST#revoke' do
    context 'given a valid access token' do
      it 'returns success status' do
        Fabricate(:access_token, token: 'access_token')

        post :revoke, params: { token: 'access_token' }

        expect(response).to have_http_status(:success)
      end

      it 'returns an empty response' do
        Fabricate(:access_token, token: 'access_token')

        post :revoke, params: { token: 'access_token' }

        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'given a valid refresh token' do
      it 'returns success status' do
        Fabricate(:access_token, refresh_token: 'refresh_token')

        post :revoke, params: { token: 'refresh_token' }

        expect(response).to have_http_status(:success)
      end

      it 'returns an empty response' do
        Fabricate(:access_token, refresh_token: 'refresh_token')

        post :revoke, params: { token: 'refresh_token' }

        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'given an invalid token' do
      it 'returns success status' do
        post :revoke, params: { token: 'invalid' }

        expect(response).to have_http_status(:success)
      end

      it 'returns an empty response' do
        post :revoke, params: { token: 'invalid' }

        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'given no token param' do
      it 'returns success status' do
        post :revoke

        expect(response).to have_http_status(:success)
      end

      it 'returns an empty response' do
        post :revoke

        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end
end
