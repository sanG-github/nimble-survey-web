# frozen_string_literal: true

require 'rails_helper'

describe 'Codebase', codebase: true do
  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to include 'All is good!'
  end

  context 'respond_to blocks' do
    it 'does not contain respond_to blocks' do
      find_results = `grep -r 'respond_to do' app/`
      expect(find_results).to be_empty
    end

    it 'does not contain format blocks' do
      find_results = `grep -r 'format.json' app/`
      expect(find_results).to be_empty
    end
  end

  it 'does NOT offend stylelint' do
    expect(`yarn run stylelint`).to include 'Done'
  end

  it 'does NOT offend eslint' do
    expect(`yarn run eslint`).to include 'Done'
  end
end
