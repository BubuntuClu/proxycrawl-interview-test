require 'rails_helper'

RSpec.describe Amazon::PagePrimeProductParseWorker do
  context 'list of products' do

    context 'put in queue products on the page' do
      before do
        stub_request(:get, "https://api.proxycrawl.com/?token=ISv3vDqqVYhWqOe1Tc1Duw&url=https://www.amazon.com/test_url").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Ruby'
            }
          ).
          to_return(status: 200, body: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/amazon_prime_products_first_page.html'), 'text/html').read, headers: {})
      end

      it 'calls Amazon::PrimeProductParseWorker' do
        expect(Amazon::PrimeProductParseWorker).to receive(:perform_async).
          with(String).exactly(16).times
        subject.perform('/test_url')
      end

      it 'calls self for next page' do
        expect(Amazon::PagePrimeProductParseWorker).to receive(:perform_async).
          with(String).exactly(1).times
        subject.perform('/test_url')
      end
    end
  end
end
