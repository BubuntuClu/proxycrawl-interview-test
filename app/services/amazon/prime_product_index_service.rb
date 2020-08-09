class Amazon::PrimeProductIndexService
  def self.call
    AmazonGood.where(good_type: 'prime_product').select("id, general_info->'title' AS name")
  end
end
