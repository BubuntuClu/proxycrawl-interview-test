class Amazon::PrimeVideo::PageParseWorker < Amazon::BaseAmazonWorker
  def perform(page)
    proxy_url = BaseScarpingService::PROXY_URL
    scarping_url = "#{proxy_url}?token=#{ENV['PROXY_TOKEN']}&url=#{MAIN_DOMAIN}#{page}"
    html = open(scarping_url)
    doc = Nokogiri::HTML(html)

    search_result = doc.at('.av-grid-wrapper')
    rows_per_page = search_result.css('.av-grid-packshot').css('div')

    rows_per_page.each do |row|
      video_url = row.children.attribute('href').value
      Amazon::PrimeVideo::ParseWorker.perform_async(video_url)
    end
  end
end
