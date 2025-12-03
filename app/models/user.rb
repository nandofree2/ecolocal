class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role, optional: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
