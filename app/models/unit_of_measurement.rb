class UnitOfMeasurement< ApplicationRecord
  has_many :products
  validates_presence_of :name, :quantity, :sku
  validates_uniqueness_of :name

  after_update :update_product_sku

  def update_product_sku
    products.find_each do |product|
      product.update!(sku: "#{product.category.sku}-#{self.sku}")
    end
  end
end
