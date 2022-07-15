# frozen_string_literal: true

class SurveySerializer < SurveyListSerializer
  has_many :questions
end
