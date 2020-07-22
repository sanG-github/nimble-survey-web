# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::PasswordsController, type: :controller do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:verify_authenticity_token) }
  end

  describe 'POST#create', devise_mapping: true do
    context 'given a valid request' do
      it 'returns created status' do
        Fabricate(:user, email: 'hoang@example.com')

        post :create, params: { user: { email: 'hoang@example.com' } }

        expect(response).to have_http_status(:created)
      end
    end

    context 'given an invalid request' do
      context 'given no email' do
        it 'returns not_found status' do
          post :create, params: { user: { email: 'hoang@example.com' } }

          expect(response).to have_http_status(:not_found)
        end

        it 'has error message' do
          post :create

          expect(JSON.parse(response.body, symbolize_names: true)).to eq(error: "Email can't be blank")
        end
      end

      context 'given a non-existing email' do
        it 'returns not_found status' do
          post :create, params: { user: { email: 'hoang@example.com' } }

          expect(response).to have_http_status(:not_found)
        end

        it 'has error message' do
          post :create, params: { user: { email: 'hoang@example.com' } }

          expect(JSON.parse(response.body, symbolize_names: true)).to eq(error: 'Email not found')
        end
      end
    end
  end
end
