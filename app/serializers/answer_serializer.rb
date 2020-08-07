# frozen_string_literal: true

class AnswerSerializer < ApplicationSerializer
  attributes :text,
             :help_text,
             :input_mask_placeholder,
             :short_text,
             :is_mandatory,
             :is_customer_first_name,
             :is_customer_last_name,
             :is_customer_title,
             :is_customer_email,
             :prompt_custom_answer,
             :weight,
             :display_order,
             :display_type,
             :input_mask,
             :date_constraint,
             :default_value,
             :response_class,
             :reference_identifier,
             :score,
             :alerts
end
