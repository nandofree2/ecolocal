class City < ApplicationRecord
  belongs_to :province
  validates_uniqueness_of :sku, :name

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "province_id", "sku", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["province"]
  end
end
