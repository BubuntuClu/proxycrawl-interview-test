class Amazon::PrimeProductDestroyService
  def self.call(params)
    prime_product = ::Amazon::PrimeProductFindService.call(params[:id])
    prime_product.destroy
  end
end
