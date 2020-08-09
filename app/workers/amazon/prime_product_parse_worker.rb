class Amazon::PrimeProductParseWorker < Amazon::BaseAmazonWorker
  def perform(page)
    good_type = 'prime_product'
    proxy_url = BaseScarpingService::PROXY_URL
    scarping_url = "#{proxy_url}?token=#{ENV['PROXY_TOKEN']}&url=#{MAIN_DOMAIN}#{page}"
    html = open(scarping_url)
    doc = Nokogiri::HTML(html)

    rel_canonical = doc.at('link[rel="canonical"]')['href']

    meta_info = {}
    meta_info[:meta_keywords] = doc.at('meta[name="keywords"]')['content']
    meta_info[:meta_title] = doc.at('meta[name="title"]')['content']
    meta_info[:meta_description] = doc.at('meta[name="description"]')['content']

    general_info = {}
    general_info[:title] = doc.at('span[id="productTitle"]').children.first.to_s.strip
    general_info[:price] = doc.at('span[id="priceblock_ourprice"]').children.first.to_s.strip
    general_info[:ratings] = doc.at('span[id="acrCustomerReviewText"]').children.first.to_s.strip
    general_info[:image] = doc.css('div').css('.imgTagWrapper').first.at('img').attributes.values.second.value.strip

    product = AmazonGood.find_by(rel_canonical: rel_canonical, good_type: good_type)

    if product.present?
      product.update(meta_info: meta_info, general_info: general_info)
    else
      AmazonGood.create(rel_canonical: rel_canonical, meta_info: meta_info, general_info: general_info, good_type: good_type)
    end
  end
end
