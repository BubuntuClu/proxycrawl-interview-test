require 'rails_helper'

RSpec.describe Api::V1::Amazon::PrimeVideosController, type: :request do

  describe '#update' do
    let!(:video) { create(:amazon_good, good_type: 'prime_video') }

    context 'return json for update action' do
      let(:action) do
        ->() {
          put api_v1_amazon_prime_video_path(video),
            params: {
              user: ENV['AUTH_USER'],
              password: ENV['AUTH_PASSWORD'],
              amazon_good: {
                rel_canonical: 'new_rel',
                meta_info: {
                  meta_title: 'new_value',
                  meta_og_image: 'some new field'
                },
                general_info: {
                  title: 'new title',
                  country: 'country'
                }
              },
            }.to_json,
            headers: { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
        }
      end

      it 'response success' do
        action.call
        expect(response).to be_successful
      end

      it 'valid json' do
        example = {
          'id' => Integer,
          'rel_canonical' => 'new_rel',
          'meta_info' => Hash,
          'general_info' => Hash,
        }

        action.call

        json = JSON.parse(response.body)

        expect(json).to match example
      end

      it 'valid json for general_info' do
        example = {
          'title' => 'new title',
          'country' => 'country'
        }

        action.call

        json = JSON.parse(response.body)
        meta_info = json.dig('general_info')
        expect(meta_info).to match example
      end

      it 'valid json for meta_info' do
        example = {
          'meta_title' => 'new_value',
          'meta_og_image' => 'some new field'
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
          put api_v1_amazon_prime_video_path(video),
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
          put api_v1_amazon_prime_video_path(-1),
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
