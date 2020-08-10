class Amazon::PrimeVideo::FindService
  def self.call(id)
    AmazonGood.find(id)
  end
end
