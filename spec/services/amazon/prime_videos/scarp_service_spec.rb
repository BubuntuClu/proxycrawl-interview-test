require 'rails_helper'

RSpec.describe Amazon::PrimeVideo::ScarpService do
  context 'prime Vieos service' do

    it 'calls worker' do
      expect(Amazon::PrimeVideo::PageParseWorker).to receive(:perform_async).
        exactly(1).times

      Amazon::PrimeVideo::ScarpService.call
    end

    it 'calls worker' do
      expect(Amazon::PrimeVideo::PageParseWorker).to receive(:perform_async).
        with(String).exactly(1).times

      Amazon::PrimeVideo::ScarpService.call('some_url')
    end
  end
end
