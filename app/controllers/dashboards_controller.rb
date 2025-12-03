class DashboardsController < ApplicationController
  def index
    @products_count = Product.count
    @categories_count = Category.count
    @unit_of_measurements_count = UnitOfMeasurement.count
    @users_count = User.count
  end
end
