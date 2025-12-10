class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit_of_measurement
  has_one_attached :cover_image
  has_many_attached :preview_images 

  validates_presence_of :name, :price
  validate :preview_images_limit

  enum status_product: {unreleased: 0,expired: 1,active: 2,deactive: 3}

  before_save :set_sku_product


  def self.ransackable_attributes(auth_object = nil)
    ["name","sku","status_product","price","category_id","unit_of_measurement_id","created_at","updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category","unit_of_measurement"]
  end

  def preview_images_limit
    if preview_images.attachments.count > 5
      errors.add(:preview_images, "cannot be more than 5 images")
    end
  end

  def set_sku_product
    self.sku = "#{self.category.sku}#{self.unit_of_measurement.sku}"
  end
end
