class Amazon::PrimeVideo::IndexService
  def self.call
    AmazonGood.where(good_type: 'prime_video').select("id, general_info->'title' AS name")
  end
end
