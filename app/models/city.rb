class City < ApplicationRecord
  belongs_to :province
  validates_uniqueness_of :sku, :name
end
