# frozen_string_literal: true

class EditApplicationFromOauthAccessTokens < ActiveRecord::Migration[6.0]
  def up
    Doorkeeper::AccessToken.where(application_id: nil).destroy_all

    change_column_null :oauth_access_tokens, :application_id, false

  end

  def down
    change_column_null :oauth_access_tokens, :application_id, true
  end
end
