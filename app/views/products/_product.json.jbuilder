json.extract! product, :id, :name, :sku, :description, :status, :quantity, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
