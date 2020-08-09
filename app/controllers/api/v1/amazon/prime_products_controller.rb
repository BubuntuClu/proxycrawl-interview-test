class Api::V1::Amazon::PrimeProductsController < Api::V1::ApplicationController
  def index
    @prime_products = ::Amazon::PrimeProductIndexService.call
  end

  def show
    @prime_product = ::Amazon::PrimeProductFindService.call(params[:id])
  end

  def destroy
    @prime_product = ::Amazon::PrimeProductDestroyService.call(params)
  end

  def update
    @prime_product = ::Amazon::PrimeProductUpdateService.call(params)
  end
end
