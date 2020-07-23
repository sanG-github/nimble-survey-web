# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survey do
  describe '.all' do
    it 'returns the survey list from file' do
      surveys = described_class.all

      expect(surveys).to all(be_a(Survey))
      expect(surveys.size).to eq(20)
    end
  end

  describe '.where' do
    context 'given valid attributes' do
      it 'returns the correct records' do
        surveys = described_class.where(is_active: true, type: 'Restaurant')

        expect(surveys).to all(be_a(Survey))
        expect(surveys.size).to eq(12)
      end
    end

    context 'given invalid attributes' do
      it 'returns the correct records' do
        surveys = described_class.where(title: 'Nimble Restaurant')

        expect(surveys).to be_empty
      end
    end
  end

  describe '.find_by' do
    context 'given valid attributes' do
      it 'returns the first matched record' do
        survey = described_class.find_by(is_active: true, type: 'Restaurant')

        expect(survey).to be_a(Survey)
        expect(survey.attributes).to include(is_active: true, type: 'Restaurant')
      end
    end

    context 'given invalid attributes' do
      it 'returns nil' do
        survey = described_class.find_by(title: 'Nimble Restaurant')

        expect(survey).to be_nil
      end
    end
  end
end
