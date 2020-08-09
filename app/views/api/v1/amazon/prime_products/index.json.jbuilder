json.prime_products do
  json.array! @prime_products do |product|
    json.partial! 'preview_prime_product', locals: { product: product }
  end
end
