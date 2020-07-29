# frozen_string_literal: true

class Answer < ApplicationModel
  attribute :id, :string
  attribute :question_id, :string
  attribute :text, :string
  attribute :help_text, :string
  attribute :input_mask_placeholder
  attribute :short_text, :string
  attribute :is_mandatory, :boolean
  attribute :is_customer_first_name, :boolean
  attribute :is_customer_last_name, :boolean
  attribute :is_customer_title, :boolean
  attribute :is_customer_email, :boolean
  attribute :prompt_custom_answer, :boolean
  attribute :weight
  attribute :display_order, :integer
  attribute :display_type, :string
  attribute :input_mask
  attribute :date_constraint
  attribute :default_value
  attribute :response_class, :string
  attribute :reference_identifier
  attribute :score, :integer
  attribute :alerts, array: true
end
