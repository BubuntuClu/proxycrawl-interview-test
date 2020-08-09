require 'rails_helper'

RSpec.describe Amazon::PrimeProductParseWorker do
  context 'load product from amazon into DB' do

    context 'prime product not exist' do
      before do
        stub_request(:get, "https://api.proxycrawl.com/?token=ISv3vDqqVYhWqOe1Tc1Duw&url=https://www.amazon.com/test_url").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Ruby'
            }
          ).
          to_return(status: 200, body: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/amazon_product_page.html'), 'text/html').read, headers: {})
      end

      it 'creates product in data base' do
        expect { subject.perform('/test_url') }.to change(AmazonGood, :count).by 1
      end
    end

    context 'prime product exist' do
      let!(:amazon_good) { create(:amazon_good, rel_canonical: 'https://www.amazon.com/Prime-Products-11-0190-Rocker-Switch/dp/B000BRJVUW', good_type: 'prime_product') }

      before do
        stub_request(:get, "https://api.proxycrawl.com/?token=ISv3vDqqVYhWqOe1Tc1Duw&url=https://www.amazon.com/test_url").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Ruby'
            }
          ).
          to_return(status: 200, body: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/amazon_product_page.html'), 'text/html').read, headers: {})
      end

      it 'does not create new product in database' do
        expect { subject.perform('/test_url') }.to change(AmazonGood, :count).by 0
      end

      it 'updates old file' do
        old_meta = amazon_good.meta_info
        old_general = amazon_good.general_info

        subject.perform('/test_url')

        amazon_good.reload

        expect(amazon_good.meta_info).not_to eq old_meta
        expect(amazon_good.general_info).not_to eq old_general
      end
    end
  end
end
