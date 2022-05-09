# frozen_string_literal: true

module Doorkeeper
  module CustomErrorResponse
    def body
      {
        errors: [
          {
            detail: description,
            code: name
          }.compact
        ]
      }
    end
  end
end
