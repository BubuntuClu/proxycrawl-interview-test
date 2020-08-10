require 'rails_helper'

RSpec.describe Api::V1::Amazon::PrimeVideosController, type: :request do

  describe '#index' do
    let!(:videos) { create_list(:amazon_good, 3, good_type: 'prime_video') }

    context 'return json for index action' do
      let(:action) do
        ->() {
          get  api_v1_amazon_prime_videos_path,
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
          'prime_videos' => Array,
        }

        action.call

        json = JSON.parse(response.body)

        expect(json).to match example
      end

      it 'valid json for prime_videos' do
        example = {
          'id' => Integer,
          'name' => String
        }

        action.call

        json = JSON.parse(response.body)
        prime_videos = json.dig('prime_videos')

        expect(prime_videos.count).to eq 3
        expect(prime_videos.first).to match example
      end
    end

    context 'return 403' do
      let(:action) do
        ->() {
          get  api_v1_amazon_prime_videos_path,
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
