class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  validates_presence_of :name, :sku
  validates_uniqueness_of :sku

  after_update :update_product_sku

  def update_product_sku
    products.find_each do |product|
      product.update!(sku: "#{self.sku}-#{product.unit_of_measurement.sku}")
    end
  end
end
