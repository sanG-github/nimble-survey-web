# frozen_string_literal: true

module Lookup
  extend ActiveSupport::Concern

  included do
    class << self
      def for(class_name)
        "#{class_name}Serializer".safe_constantize
      end
    end
  end
end
