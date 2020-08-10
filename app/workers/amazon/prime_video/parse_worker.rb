class Amazon::PrimeVideo::ParseWorker < Amazon::BaseAmazonWorker
  def perform(page)
    good_type = 'prime_video'
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
    general_info[:title] = doc.at('h1[data-automation-id="title"]').children.first.to_s.strip
    general_info[:movie_length] = doc.at('span[data-automation-id="runtime-badge"]').children.first.to_s.strip
    general_info[:release_year] = doc.at('span[data-automation-id="release-year-badge"]').children.first.to_s.strip
    general_info[:director] = doc.at('._1NNx6V').children.first.to_s.strip

    video = AmazonGood.find_by(rel_canonical: rel_canonical, good_type: good_type)

    if video.present?
      video.update(meta_info: meta_info, general_info: general_info)
    else
      AmazonGood.create(rel_canonical: rel_canonical, meta_info: meta_info, general_info: general_info, good_type: good_type)
    end
  end
end
