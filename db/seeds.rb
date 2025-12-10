# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create default roles
admin_role = Role.find_or_create_by!(name: "Admin") do |role|
  role.description = "Full access to all features and user management"
end

manager_role = Role.find_or_create_by!(name: "Manager") do |role|
  role.description = "Can manage products, categories, and view users"
end

user_role = Role.find_or_create_by!(name: "User") do |role|
  role.description = "Can view products and categories only"
end

# Create a default admin user
User.find_or_create_by!(email: "admin@test.com") do |user|
  user.name = "Administrator"
  user.password = "12341234"
  user.password_confirmation = "12341234"
  user.role = admin_role
end

User.find_or_create_by!(email: "manager@test.com") do |user|
  user.name = "Manager"
  user.password = "12341234"
  user.password_confirmation = "12341234"
  user.role = manager_role
end

unless Category.exists?(1)
  Category.create!(id: 1, name: "T-shirt", sku: "TS")
  Category.create!(id: 2, name: "Jeans", sku: "JN")
  Category.create!(id: 3, name: "Sweater", sku: "SW")
  Category.create!(id: 4, name: "accessories", sku: "AC")
  Category.create!(id: 5, name: "dresses", sku: "DR")
end

unless UnitOfMeasurement.exists?(1)
  UnitOfMeasurement.create!(id: 1, name: "PCS", sku: "PC", quantity:1)
  UnitOfMeasurement.create!(id: 2, name: "Lusin", sku: "LS", quantity:12)
  UnitOfMeasurement.create!(id: 3, name: "Box", sku: "BX", quantity:20)
  UnitOfMeasurement.create!(id: 4, name: "Gross", sku: "GR", quantity:144)
end

# random generator simple

100.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    sku: rand(10000..99999).to_s,
    description: Faker::Lorem.sentence(word_count: 5),
    status_product: 1,
    price: rand(10.0..500.0).round(2),
    category_id: rand(1..5),
    unit_of_measurement_id: rand(1..4)
  )
end

puts "✅ Seeding complete! Created roles: Admin, Manager, User"
puts "📧 Test Admin account: admin@test.com / 12341234"
puts "📧 Test manager account: manager@test.com / 12341234"

