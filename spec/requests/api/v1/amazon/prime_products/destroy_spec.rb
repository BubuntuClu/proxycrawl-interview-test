require 'rails_helper'

RSpec.describe Api::V1::Amazon::PrimeProductsController, type: :request do

  describe '#destroy' do
    let!(:product) { create(:amazon_good, good_type: 'prime_product') }

    context 'return json for destroy action' do
      let(:action) do
        ->() {
          delete api_v1_amazon_prime_product_path(product),
            params: { user: ENV['AUTH_USER'], password: ENV['AUTH_PASSWORD'] }.to_json,
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_successful
      end

      it 'deletes product from DB' do
        expect { action.call }.to change(AmazonGood, :count).by (-1)
      end

      it 'valid json' do
        example = {
          'id' => Integer,
          'rel_canonical' => String,
          'meta_info' => Hash,
          'general_info' => Hash,
        }

        action.call

        json = JSON.parse(response.body)

        expect(json).to match example
      end

      it 'valid json for general_info' do
        example = {
          'image' => String,
          'price' => String,
          'ratings' => String,
          'title' => String,
        }

        action.call

        json = JSON.parse(response.body)
        meta_info = json.dig('general_info')
        expect(meta_info).to match example
      end

      it 'valid json for meta_info' do
        example = {
          'meta_title' => String,
          'meta_description' => String,
          'meta_keywords' => String,
        }

        action.call

        json = JSON.parse(response.body)
        meta_info = json.dig('meta_info')
        expect(meta_info).to match example
      end
    end

    context 'return 403' do
      let(:action) do
        ->() {
          delete api_v1_amazon_prime_product_path(product),
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_unauthorized
      end
    end

    context 'return 404' do
      let(:action) do
        ->() {
          delete api_v1_amazon_prime_product_path(-1),
            params: { user: ENV['AUTH_USER'], password: ENV['AUTH_PASSWORD'] }.to_json,
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_not_found
      end
    end
  end
end
