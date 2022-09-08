# frozen_string_literal: true

class SurveySimpleSerializer < ApplicationSerializer
  attributes :title,
             :description,
             :thank_email_above_threshold,
             :thank_email_below_threshold,
             :is_active,
             :cover_image_url,
             :created_at,
             :active_at,
             :inactive_at

  attribute :survey_type, &:type
end
