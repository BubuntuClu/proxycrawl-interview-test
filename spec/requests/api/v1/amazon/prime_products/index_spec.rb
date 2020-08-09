require 'rails_helper'

RSpec.describe Api::V1::Amazon::PrimeProductsController, type: :request do

  describe '#index' do
    let!(:products) { create_list(:amazon_good, 3, good_type: 'prime_product') }

    context 'return json for index action' do
      let(:action) do
        ->() {
          get  api_v1_amazon_prime_products_path,
            params: { user: ENV['AUTH_USER'], password: ENV['AUTH_PASSWORD'] },
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_successful
      end

      it 'valid json' do
        example = {
          'prime_products' => Array,
        }

        action.call

        json = JSON.parse(response.body)

        expect(json).to match example
      end

      it 'valid json for prime_products' do
        example = {
          'id' => Integer,
          'name' => String
        }

        action.call

        json = JSON.parse(response.body)
        prime_products = json.dig('prime_products')

        expect(prime_products.count).to eq 3
        expect(prime_products.first).to match example
      end
    end

    context 'return 403' do
      let(:action) do
        ->() {
          get  api_v1_amazon_prime_products_path,
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_unauthorized
      end
    end
  end
end
