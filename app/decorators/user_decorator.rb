# frozen_string_literal: true

class UserDecorator < SimpleDelegator
  AVATAR_URL_FORMAT = 'https://secure.gravatar.com/avatar/%{gravatar_id}'

  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(email)
    format(AVATAR_URL_FORMAT, gravatar_id: gravatar_id)
  end
end
