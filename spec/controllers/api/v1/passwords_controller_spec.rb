# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::PasswordsController, type: :controller do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:verify_authenticity_token) }
  end

  describe 'POST#create', devise_mapping: true do
    context 'given a valid request' do
      it 'returns success status' do
        Fabricate(:user, email: 'hoang@example.com')

        post :create, params: { user: { email: 'hoang@example.com' } }

        expect(response).to have_http_status(:success)
      end

      it 'has a message' do
        Fabricate(:user, email: 'hoang@example.com')

        post :create, params: { user: { email: 'hoang@example.com' } }

        expected_response = {
          meta: {
            message: I18n.t('devise.passwords.send_paranoid_instructions')
          }
        }
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
      end
    end

    context 'given an invalid request' do
      context 'given no email' do
        it 'returns success status' do
          post :create

          expect(response).to have_http_status(:success)
        end

        it 'has a message' do
          post :create

          expected_response = {
            meta: {
              message: I18n.t('devise.passwords.send_paranoid_instructions')
            }
          }
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
        end
      end

      context 'given a non-existing email' do
        it 'returns success status' do
          post :create, params: { user: { email: 'hoang@example.com' } }

          expect(response).to have_http_status(:success)
        end

        it 'has a message' do
          post :create, params: { user: { email: 'hoang@example.com' } }

          expected_response = {
            meta: {
              message: I18n.t('devise.passwords.send_paranoid_instructions')
            }
          }
          expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
        end
      end
    end
  end
end
