class Amazon::PagePrimeProductParseWorker < Amazon::BaseAmazonWorker
  def perform(page)
    proxy_url = BaseScarpingService::PROXY_URL
    scarping_url = "#{proxy_url}?token=#{ENV['PROXY_TOKEN']}&url=#{MAIN_DOMAIN}#{page}"
    html = open(scarping_url)
    doc = Nokogiri::HTML(html)

    search_result = doc.css('#search')
    table_with_results = search_result.css('.s-main-slot').css('.sg-row')
    rows_per_page = table_with_results.css('.s-result-item').css('.a-size-mini').css('.a-link-normal')

    rows_per_page.each do |row|
      product_url = row.attribute('href').value
      Amazon::PrimeProductParseWorker.perform_async(product_url)
    end

    next_page = doc.at('.a-last')&.children&.first&.attribute('href')&.value
    Amazon::PagePrimeProductParseWorker.perform_async(next_page) if next_page.present?
  end
end
