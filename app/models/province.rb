class Province < ApplicationRecord
  has_many :cities
  validates_uniqueness_of :sku, :name
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "sku", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cities"]
  end
end
