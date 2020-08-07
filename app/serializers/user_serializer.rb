# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  AVATAR_URL_FORMAT = 'https://api.adorable.io/avatar/%{email}'

  attribute :email

  attribute :avatar_url do |user|
    format(AVATAR_URL_FORMAT, email: user.email)
  end
end
