class User < ApplicationRecord
  has_secure_password # provided by 'bcrypt'
  has_many :posts
  validates_presence_of :name, :email, :password_digest
end
