# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::PasswordsController, type: :controller do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:verify_authenticity_token) }
  end

  describe 'POST#create', devise_mapping: true do
    context 'given a valid oauth application' do
      context 'given a valid request' do
        it 'returns success status' do
          Fabricate(:user, email: 'hoang@example.com')

          post :create, params: { email: 'hoang@example.com' }.merge(oauth_application_params)

          expect(response).to have_http_status(:success)
        end

        it 'has a message' do
          Fabricate(:user, email: 'hoang@example.com')

          post :create, params: { email: 'hoang@example.com' }.merge(oauth_application_params)

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
            post :create, params: oauth_application_params

            expect(response).to have_http_status(:success)
          end

          it 'has a message' do
            post :create, params: oauth_application_params

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
            post :create, params: { email: 'hoang@example.com' }.merge(oauth_application_params)

            expect(response).to have_http_status(:success)
          end

          it 'has a message' do
            post :create, params: { email: 'hoang@example.com' }.merge(oauth_application_params)

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

    context 'given an invalid oauth application' do
      it 'returns forbidden status' do
        post :create, params: { email: 'hoang@example.com' }

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        post :create, params: { email: 'hoang@example.com' }

        expected_response = {
          errors: [
            {
              code: 'invalid_client',
              detail: 'Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.'
            }
          ]
        }
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
      end
    end
  end
end
