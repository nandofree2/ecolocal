class Province < ApplicationRecord
  validates_uniqueness_of :sku, :name
end
