class Amazon::PrimeProductScarpService < BaseScarpingService
  def self.call(initial_page = nil)
    initial_page ||= '/s?srs=3039187011'

    Amazon::PagePrimeProductParseWorker.perform_async(initial_page)
  end
end
