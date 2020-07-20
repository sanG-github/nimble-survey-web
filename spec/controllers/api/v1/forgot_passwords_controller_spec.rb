# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::ForgotPasswordsController do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:doorkeeper_authorize!) }
  end

  describe 'POST#create' do
    context 'given a valid request' do
      it 'returns 200 status' do
        Fabricate(:user, email: 'hoang@example.com')

        post :create, params: { email: 'hoang@example.com' }

        expect(response.status).to eq(201)
      end
    end

    context 'given an invalid request' do
      it 'returns 401 status' do
        post :create

        expect(response.status).to eq(404)
      end
    end
  end
end
