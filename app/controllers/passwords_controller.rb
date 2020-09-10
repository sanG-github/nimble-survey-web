# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    set_flash_message!(:notice, :updated_not_active) if resource.errors.empty?

    render :edit
  end
end
