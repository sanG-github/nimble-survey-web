# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResponseForm do
  describe '#save' do
    context 'given valid attributes' do
      context 'given a same questions order' do
        it 'returns true' do
          questions_ids = [
            { id: '940d229e4cd87cd1e202' },
            { id: 'c3a9b8ce5c2356010703' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)

          expect(form.save).to eq(true)
        end

        it 'does NOT have errors' do
          questions_ids = [
            { id: '940d229e4cd87cd1e202' },
            { id: 'c3a9b8ce5c2356010703' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)
          form.save

          expect(form.errors).to be_empty
        end
      end

      context 'given a different questions order' do
        it 'returns true' do
          questions_ids = [
            { id: 'c3a9b8ce5c2356010703' },
            { id: '940d229e4cd87cd1e202' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)

          expect(form.save).to eq(true)
        end

        it 'does NOT have errors' do
          questions_ids = [
            { id: 'c3a9b8ce5c2356010703' },
            { id: '940d229e4cd87cd1e202' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)
          form.save

          expect(form.errors).to be_empty
        end
      end
    end

    context 'given invalid attributes' do
      context 'given an invalid survey ID' do
        it 'returns false' do
          form = described_class.new(survey_id: 'invalid')

          expect(form.save).to eq(false)
        end

        it 'has error messages' do
          form = described_class.new(survey_id: 'invalid')
          form.save

          expect(form.errors.messages[:survey]).to include('is invalid')
        end
      end

      context 'given invalid questions IDs' do
        it 'returns false' do
          questions_ids = [
            { id: 'invalid' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)

          expect(form.save).to eq(false)
        end

        it 'has error messages' do
          questions_ids = [
            { id: 'invalid' }
          ]
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: questions_ids)
          form.save

          expect(form.errors.messages[:questions]).to include('is invalid')
        end
      end

      context 'given an empty questions array' do
        it 'returns false' do
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: [])

          expect(form.save).to eq(false)
        end

        it 'has error messages' do
          form = described_class.new(survey_id: 'd5de6a8f8f5f1cfe51bc', questions: [])
          form.save

          expect(form.errors.messages[:questions]).to include("can't be blank")
        end
      end
    end
  end
end
