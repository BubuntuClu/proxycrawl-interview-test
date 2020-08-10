class Amazon::PrimeProduct::ScarpService < BaseScarpingService
  def self.call(initial_page = nil)
    initial_page ||= '/s?srs=3039187011'

    Amazon::PrimeProduct::PageParseWorker.perform_async(initial_page)
  end
end
