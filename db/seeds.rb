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

puts "✅ Seeding complete! Created roles: Admin, Manager, User"
puts "📧 Test Admin account: admin@test.com / 12341234"
puts "📧 Test manager account: manager@test.com / 12341234"

