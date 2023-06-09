# frozen_string_literal: true

class OpenapiController < ApplicationController
  def show
    render template: 'openapi/swagger'
  end
end
