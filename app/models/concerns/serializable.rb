# frozen_string_literal: true

module Serializable
  extend ActiveSupport::Concern

  included do
    # :reek:NilCheck
    def as_json(options = {})
      serializer = options[:serializer].to_s.safe_constantize || ApplicationSerializer.for(self.class.name)
      return super(options) if serializer.nil?

      serializer.new(self, options).serializable_hash
    end
  end
end
