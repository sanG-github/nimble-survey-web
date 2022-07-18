# frozen_string_literal: true

class SurveySerializer < SurveySimpleSerializer
  has_many :questions
end
