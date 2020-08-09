class Amazon::PrimeProductFindService
  def self.call(id)
    AmazonGood.find(id)
  end
end
