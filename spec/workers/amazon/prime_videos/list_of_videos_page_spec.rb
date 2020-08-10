require 'rails_helper'

RSpec.describe Amazon::PrimeVideo::PageParseWorker do
  context 'list of videos' do

    context 'put in queue Video::s on the page' do
      before do
        stub_request(:get, "https://api.proxycrawl.com/?token=ISv3vDqqVYhWqOe1Tc1Duw&url=https://www.amazon.com/test_url").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Ruby'
            }
          ).
          to_return(status: 200, body: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/amazon_prime_video_first_page.html'), 'text/html').read, headers: {})
      end

      it 'calls Amazon::PrimeVideo::ParseWorker' do
        expect(Amazon::PrimeVideo::ParseWorker).to receive(:perform_async).
          with(String).exactly(20).times
        subject.perform('/test_url')
      end
    end
  end
end
