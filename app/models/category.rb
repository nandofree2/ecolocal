class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  validates_presence_of :name, :sku
  validates_uniqueness_of :name, :sku

  after_update :update_product_sku

  def self.ransackable_attributes(auth_object = nil)
    ["id","name","sku","description","created_at","updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end

  def update_product_sku
    products.find_each do |product|
      product.update!(sku: "#{self.sku}-#{product.unit_of_measurement.sku}")
    end
  end
end
