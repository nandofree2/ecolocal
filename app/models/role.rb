class Role < ApplicationRecord
  has_many :users, dependent: :nullify
  validates :name, presence: true, uniqueness: true

  def permissions_hash
    (permissions || {}).transform_keys(&:to_s)
  end
end
