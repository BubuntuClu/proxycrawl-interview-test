class Amazon::PrimeProduct::DestroyService
  def self.call(params)
    prime_product = ::Amazon::PrimeProduct::FindService.call(params[:id])
    prime_product.destroy
  end
end
