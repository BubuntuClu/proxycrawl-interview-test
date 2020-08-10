class Api::V1::Amazon::PrimeProductsController < Api::V1::ApplicationController
  def index
    @prime_products = ::Amazon::PrimeProduct::IndexService.call
  end

  def show
    @prime_product = ::Amazon::PrimeProduct::FindService.call(params[:id])
  end

  def destroy
    @prime_product = ::Amazon::PrimeProduct::DestroyService.call(params)
  end

  def update
    @prime_product = ::Amazon::PrimeProduct::UpdateService.call(params)
  end
end
