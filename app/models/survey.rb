# frozen_string_literal: true

class Survey < ApplicationModel
  attribute :id, :string
  attribute :title, :string
  attribute :description, :string
  attribute :access_code_prompt
  attribute :thank_email_above_threshold, :string
  attribute :thank_email_below_threshold, :string
  attribute :footer_content, :string
  attribute :is_active, :boolean
  attribute :cover_image_url, :string
  attribute :cover_background_color
  attribute :type, :string
  attribute :created_at, :datetime
  attribute :active_at, :datetime
  attribute :inactive_at, :datetime
  attribute :survey_version, :integer
  attribute :short_url, :string
  attribute :language_list, array: true
  attribute :default_language, :string
  attribute :tag_list, :string
  attribute :is_access_code_required, :boolean
  attribute :is_access_code_valid_required, :boolean
  attribute :access_code_validation, :string
  attribute :theme

  has_many :questions, Question

  class << self
    def all
      @all ||= begin
        JSON.parse(File.read(Rails.root.join('lib', 'assets', 'surveys.json'))).map(&method(:new))
      end
    end

    def where(options = {})
      all.select { |survey| survey.attributes >= options }
    end

    def find_by(options = {})
      all.find { |survey| survey.attributes >= options }
    end
  end
end
