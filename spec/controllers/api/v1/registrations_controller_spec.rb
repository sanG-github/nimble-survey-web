# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::RegistrationsController, type: :controller do
  describe 'Filters' do
    it { is_expected.not_to use_before_action(:verify_authenticity_token) }
    it { is_expected.to use_before_action(:verify_oauth_application) }
  end

  describe 'POST#create', devise_mapping: true do
    context 'given a valid oauth application' do
      context 'given a valid request' do
        context 'given password_confirmation param' do
          it 'returns created status' do
            user_info = {
              email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:created)
          end

          it 'returns an empty response body' do
            user_info = {
              email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response.body).to be_empty
          end
        end

        context 'given no password_confirmation param' do
          it 'returns created status' do
            user_info = {
              email: 'dev@nimblehq.co', password: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:created)
          end

          it 'returns an empty response body' do
            user_info = {
              email: 'dev@nimblehq.co', password: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response.body).to be_empty
          end
        end
      end

      context 'given an invalid request' do
        context 'given no user param' do
          it 'returns unprocessable_entity status' do
            post :create, params: oauth_application_params

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has an error message' do
            post :create, params: oauth_application_params

            expected_response = {
              errors: [
                { detail: "Email can't be blank and Password can't be blank" }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end

        context 'given no email param' do
          it 'returns unprocessable_entity status' do
            user_info = {
              password: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has an error message' do
            user_info = {
              password: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expected_response = {
              errors: [
                { detail: "Email can't be blank" }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end

        context 'given an existing email' do
          it 'returns unprocessable_entity status' do
            Fabricate(:user, email: 'dev@nimblehq.co')
            user_info = {
              email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has a message' do
            Fabricate(:user, email: 'dev@nimblehq.co')
            user_info = {
              email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expected_response = {
              errors: [
                { detail: 'Email has already been taken' }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end

        context 'given an invalid email' do
          it 'returns unprocessable_entity status' do
            user_info = {
              email: 'email', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has an error message' do
            user_info = {
              email: 'email', password: '123456', password_confirmation: '123456'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expected_response = {
              errors: [
                { detail: 'Email is invalid' }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end

        context 'given no password param' do
          it 'returns unprocessable_entity status' do
            user_info = {
              email: 'dev@nimblehq.co'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has an error message' do
            user_info = {
              email: 'dev@nimblehq.co'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expected_response = {
              errors: [
                { detail: "Password can't be blank" }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end

        context 'given a short password' do
          it 'returns unprocessable_entity status' do
            user_info = {
              email: 'dev@nimblehq.co', password: '1', password_confirmation: '1'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'has an error message' do
            user_info = {
              email: 'dev@nimblehq.co', password: '1', password_confirmation: '1'
            }
            post :create, params: { user: user_info }.merge(oauth_application_params)

            expected_response = {
              errors: [
                { detail: 'Password is too short (minimum is 6 characters)' }
              ]
            }
            expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected_response)
          end
        end
      end
    end

    context 'given an invalid oauth application' do
      it 'returns forbidden status' do
        user_info = {
          email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
        }
        post :create, params: { user: user_info }.merge({ client_id: '', client_secret: '' })

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns an error message' do
        user_info = {
          email: 'dev@nimblehq.co', password: '123456', password_confirmation: '123456'
        }
        post :create, params: { user: user_info }.merge({ client_id: '', client_secret: '' })

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
