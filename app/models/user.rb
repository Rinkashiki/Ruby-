class User < ApplicationRecord

  #has_secure_password

  #alias_attribute :password_digest, :password
  validates :name, :surname, presence: true
  validates :email, presence: true, uniqueness: true

  belongs_to :profile

end
