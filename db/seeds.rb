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

puts "✅ Created roles: Admin, Manager, User"
puts "📧 Test Admin account: admin@test.com / 12341234"
puts "📧 Test manager account: manager@test.com / 12341234"

unless Category.exists?(1)
  Category.find_or_create_by!(id: 1, name: "T-shirt", sku: "TS")
  Category.find_or_create_by!(id: 2, name: "Jeans", sku: "JN")
  Category.find_or_create_by!(id: 3, name: "Sweater", sku: "SW")
  Category.find_or_create_by!(id: 4, name: "accessories", sku: "AC")
  Category.find_or_create_by!(id: 5, name: "dresses", sku: "DR")
end

puts "✅ Created Categories"

unless UnitOfMeasurement.exists?(1)
  UnitOfMeasurement.find_or_create_by!(id: 1, name: "PCS", sku: "PC", quantity:1)
  UnitOfMeasurement.find_or_create_by!(id: 2, name: "Lusin", sku: "LS", quantity:12)
  UnitOfMeasurement.find_or_create_by!(id: 3, name: "Box", sku: "BX", quantity:20)
  UnitOfMeasurement.find_or_create_by!(id: 4, name: "Gross", sku: "GR", quantity:144)
end
puts "✅ Created Unit of Measurements"

100.times do
  Product.find_or_create_by!(
    name: Faker::Commerce.product_name,
    sku: rand(10000..99999).to_s,
    description: Faker::Lorem.sentence(word_count: 5),
    status_product: 1,
    price: rand(10.0..500.0).round(2),
    category_id: rand(1..5),
    unit_of_measurement_id: rand(1..4)
    )
  end

puts "✅ Created 100 sample products"

provinces = [
  { name: "Aceh", sku: "AC", description: "Provinsi Aceh di bagian barat Indonesia." },
  { name: "Sumatera Utara", sku: "SU", description: "Provinsi Sumatera Utara." },
  { name: "Sumatera Barat", sku: "SB", description: "Provinsi Sumatera Barat." },
  { name: "Riau", sku: "RI", description: "Provinsi Riau." },
  { name: "Kepulauan Riau", sku: "KR", description: "Provinsi Kepulauan Riau." },
  { name: "Jambi", sku: "JA", description: "Provinsi Jambi." },
  { name: "Sumatera Selatan", sku: "SS", description: "Provinsi Sumatera Selatan." },
  { name: "Bangka Belitung", sku: "BB", description: "Provinsi Kepulauan Bangka Belitung." },
  { name: "Bengkulu", sku: "BE", description: "Provinsi Bengkulu." },
  { name: "Lampung", sku: "LA", description: "Provinsi Lampung." },

  { name: "DKI Jakarta", sku: "JK", description: "Daerah Khusus Ibukota Jakarta." },
  { name: "Banten", sku: "BT", description: "Provinsi Banten." },
  { name: "Jawa Barat", sku: "JB", description: "Provinsi Jawa Barat." },
  { name: "Jawa Tengah", sku: "JT", description: "Provinsi Jawa Tengah." },
  { name: "DI Yogyakarta", sku: "YO", description: "Daerah Istimewa Yogyakarta." },
  { name: "Jawa Timur", sku: "JI", description: "Provinsi Jawa Timur." },

  { name: "Bali", sku: "BA", description: "Provinsi Bali." },
  { name: "Nusa Tenggara Barat", sku: "NB", description: "Provinsi Nusa Tenggara Barat." },
  { name: "Nusa Tenggara Timur", sku: "NT", description: "Provinsi Nusa Tenggara Timur." },

  { name: "Kalimantan Barat", sku: "KB", description: "Provinsi Kalimantan Barat." },
  { name: "Kalimantan Tengah", sku: "KT", description: "Provinsi Kalimantan Tengah." },
  { name: "Kalimantan Selatan", sku: "KS", description: "Provinsi Kalimantan Selatan." },
  { name: "Kalimantan Timur", sku: "KI", description: "Provinsi Kalimantan Timur." },
  { name: "Kalimantan Utara", sku: "KU", description: "Provinsi Kalimantan Utara." },

  { name: "Sulawesi Utara", sku: "SLU", description: "Provinsi Sulawesi Utara." },
  { name: "Sulawesi Tengah", sku: "SLT", description: "Provinsi Sulawesi Tengah." },
  { name: "Sulawesi Selatan", sku: "SLS", description: "Provinsi Sulawesi Selatan." },
  { name: "Sulawesi Tenggara", sku: "SLG", description: "Provinsi Sulawesi Tenggara." },
  { name: "Gorontalo", sku: "GO", description: "Provinsi Gorontalo." },
  { name: "Sulawesi Barat", sku: "SLB", description: "Provinsi Sulawesi Barat." },

  { name: "Maluku", sku: "MA", description: "Provinsi Maluku." },
  { name: "Maluku Utara", sku: "MU", description: "Provinsi Maluku Utara." },

  { name: "Papua", sku: "PP", description: "Provinsi Papua." },
  { name: "Papua Barat", sku: "PB", description: "Provinsi Papua Barat." },
  { name: "Papua Barat Daya", sku: "PBD", description: "Provinsi Papua Barat Daya." },
  { name: "Papua Selatan", sku: "PS", description: "Provinsi Papua Selatan." },
  { name: "Papua Tengah", sku: "PT", description: "Provinsi Papua Tengah." },
  { name: "Papua Pegunungan", sku: "PPG", description: "Provinsi Papua Pegunungan." }
]

provinces.each do |prov|
  Province.find_or_create_by!(name: prov[:name]) do |p|
    p.sku = prov[:sku]
    p.description = prov[:description]
  end
end

puts "Seeder: #{Province.count} provinces loaded."

cities = [
  { province: "Aceh", name: "Kota Banda Aceh", sku: "BDA" },
  { province: "Aceh", name: "Kota Sabang", sku: "SBG" },
  { province: "Aceh", name: "Kabupaten Aceh Besar", sku: "ABR" },
  { province: "Sumatera Utara", name: "Kota Medan", sku: "MDN" },
  { province: "Sumatera Utara", name: "Kota Binjai", sku: "BNJ" },
  { province: "Sumatera Utara", name: "Kabupaten Deli Serdang", sku: "DLS" },
  { province: "Sumatera Barat", name: "Kota Padang", sku: "PDG" },
  { province: "Sumatera Barat", name: "Kota Bukittinggi", sku: "BKT" },
  { province: "Riau", name: "Kota Pekanbaru", sku: "PKU" },
  { province: "Riau", name: "Kabupaten Kampar", sku: "KPR" },
  { province: "Kepulauan Riau", name: "Kota Batam", sku: "BTM" },
  { province: "Kepulauan Riau", name: "Kota Tanjung Pinang", sku: "TJP" },
  { province: "Jambi", name: "Kota Jambi", sku: "JMB" },
  { province: "Jambi", name: "Kabupaten Muaro Jambi", sku: "MRJ" },
  { province: "Sumatera Selatan", name: "Kota Palembang", sku: "PLB" },
  { province: "Sumatera Selatan", name: "Kabupaten Banyuasin", sku: "BNY" },
  { province: "Bangka Belitung", name: "Kota Pangkal Pinang", sku: "PKP" },
  { province: "Bangka Belitung", name: "Kabupaten Bangka", sku: "BNG" },
  { province: "Bengkulu", name: "Kota Bengkulu", sku: "BGL" },
  { province: "Lampung", name: "Kota Bandar Lampung", sku: "BDL" },
  { province: "Lampung", name: "Kabupaten Lampung Selatan", sku: "LPS" },
  { province: "DKI Jakarta", name: "Kota Jakarta Pusat", sku: "JP" },
  { province: "DKI Jakarta", name: "Kota Jakarta Selatan", sku: "JS" },
  { province: "DKI Jakarta", name: "Kota Jakarta Barat", sku: "JB" },
  { province: "Banten", name: "Kota Serang", sku: "SRG" },
  { province: "Banten", name: "Kota Tangerang", sku: "TNG" },
  { province: "Jawa Barat", name: "Kota Bandung", sku: "BDG" },
  { province: "Jawa Barat", name: "Kota Bekasi", sku: "BKS" },
  { province: "Jawa Barat", name: "Kabupaten Bogor", sku: "BGR" },
  { province: "Jawa Tengah", name: "Kota Semarang", sku: "SMG" },
  { province: "Jawa Tengah", name: "Kota Surakarta", sku: "SLO" },
  { province: "DI Yogyakarta", name: "Kota Yogyakarta", sku: "YGY" },
  { province: "DI Yogyakarta", name: "Kabupaten Sleman", sku: "SLM" },
  { province: "Jawa Timur", name: "Kota Surabaya", sku: "SBY" },
  { province: "Jawa Timur", name: "Kota Malang", sku: "MLG" },
  { province: "Jawa Timur", name: "Kabupaten Sidoarjo", sku: "SDA" },
  { province: "Bali", name: "Kota Denpasar", sku: "DPS" },
  { province: "Bali", name: "Kabupaten Badung", sku: "BDG" },
  { province: "Nusa Tenggara Barat", name: "Kota Mataram", sku: "MTR" },
  { province: "Nusa Tenggara Timur", name: "Kota Kupang", sku: "KPG" },
  { province: "Kalimantan Timur", name: "Kota Samarinda", sku: "SMD" },
  { province: "Kalimantan Timur", name: "Kota Balikpapan", sku: "BPP" },
  { province: "Sulawesi Selatan", name: "Kota Makassar", sku: "MKS" },
  { province: "Maluku", name: "Kota Ambon", sku: "AMN" },
  { province: "Papua", name: "Kota Jayapura", sku: "JPR" },
  { province: "Papua Barat", name: "Kota Manokwari", sku: "MKW" }
]

cities.each do |city|
  province = Province.find_by!(name: city[:province])

  City.find_or_create_by!(
    name: city[:name],
    province_id: province.id
  ) do |c|
    c.sku = city[:sku]
    c.description = "Kota/Kabupaten #{city[:name]} di Provinsi #{province.name}"
  end
end

puts "Seeder cities completed: #{City.count} cities loaded."
