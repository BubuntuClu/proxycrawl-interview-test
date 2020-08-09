class Amazon::PrimeProductUpdateService
  def self.call(params)
    prime_product = ::Amazon::PrimeProductFindService.call(params[:id])
    prime_product.update(prime_product_params(params))
    prime_product
  end

  private

  def self.prime_product_params(params)
    params.require(:amazon_good).permit(:rel_canonical, meta_info: {}, general_info: {})
  end
end
