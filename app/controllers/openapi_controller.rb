# frozen_string_literal: true

class OpenapiController < ApplicationController
  def show
    render 'openapi/swagger'
  end
end
