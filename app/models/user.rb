class User < ApplicationRecord
  has_many :api_keys, as: :bearer, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest, require: true
  has_secure_password
end
