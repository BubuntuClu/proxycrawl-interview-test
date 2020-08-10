require 'rails_helper'

RSpec.describe Amazon::PrimeProduct::ScarpService do
  context 'prime products service' do

    it 'calls worker' do
      expect(Amazon::PrimeProduct::PageParseWorker).to receive(:perform_async).
        exactly(1).times

      Amazon::PrimeProduct::ScarpService.call
    end

    it 'calls worker' do
      expect(Amazon::PrimeProduct::PageParseWorker).to receive(:perform_async).
        with(String).exactly(1).times

      Amazon::PrimeProduct::ScarpService.call('some_url')
    end
  end
end
