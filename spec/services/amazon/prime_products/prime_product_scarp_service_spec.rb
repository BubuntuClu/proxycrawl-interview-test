require 'rails_helper'

RSpec.describe Amazon::PrimeProductScarpService do
  context 'prime products service' do

    it 'calls worker' do
      expect(Amazon::PagePrimeProductParseWorker).to receive(:perform_async).
        exactly(1).times

      Amazon::PrimeProductScarpService.call
    end

    it 'calls worker' do
      expect(Amazon::PagePrimeProductParseWorker).to receive(:perform_async).
        with(String).exactly(1).times

      Amazon::PrimeProductScarpService.call('some_url')
    end
  end
end
