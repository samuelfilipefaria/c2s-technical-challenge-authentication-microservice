class User < ApplicationRecord
  validates_presence_of :name, :email, :password
  validates :email, uniqueness: true
end
