class Province < ApplicationRecord
  has_many :cities
  validates_uniqueness_of :sku, :name
end
