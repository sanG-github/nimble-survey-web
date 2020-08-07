# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::ApplicationController do
  controller do
    def index
      render json: { success: true }
    end
  end

  describe 'Filters' do
    it { is_expected.to use_before_action(:doorkeeper_authorize!) }
  end

  describe 'GET#index' do
    context 'given an authenticated request', auth: :user_token do
      it 'returns success status' do
        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context 'given an unauthenticated request' do
      it 'returns unauthorized status' do
        get :index

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
