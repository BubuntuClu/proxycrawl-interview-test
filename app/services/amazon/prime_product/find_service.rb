class Amazon::PrimeProduct::FindService
  def self.call(id)
    AmazonGood.find(id)
  end
end
