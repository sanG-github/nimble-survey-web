# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable,
  # :confirmable, :lockable, :timeoutable, :trackable, :rememberable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           inverse_of: :resource_owner,
           dependent: :delete_all
end
