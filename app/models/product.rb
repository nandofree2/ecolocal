class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit_of_measurement
  validates_presence_of :name, :quantity, :price

  enum status_product: {unreleased: 0,expired: 1,active: 2,deactive: 3}

  before_save :set_sku_product

  def set_sku_product
    self.sku = "#{self.category.sku}#{self.unit_of_measurement.sku}"
  end
end
