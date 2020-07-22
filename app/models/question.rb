# frozen_string_literal: true

class Question < ApplicationModel
  attribute :id, :string
  attribute :text, :string
  attribute :help_text
  attribute :display_order, :integer
  attribute :short_text, :string
  attribute :pick, :string
  attribute :display_type, :string
  attribute :is_mandatory, :boolean
  attribute :correct_answer_id
  attribute :facebook_profile
  attribute :twitter_profile
  attribute :image_url, :string
  attribute :cover_image_url, :string
  attribute :cover_image_opacity, :float
  attribute :cover_background_color
  attribute :is_shareable_on_facebook, :boolean
  attribute :is_shareable_on_twitter, :boolean
  attribute :font_face
  attribute :font_size
  attribute :tag_list, :string

  has_many :answers, Answer
end
