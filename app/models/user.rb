class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create

  has_secure_password
end
