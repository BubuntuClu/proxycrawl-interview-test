FactoryBot.define do
  factory :amazon_good do
    rel_canonical { FFaker::Internet.http_url }
    meta_info {
      {
        meta_keywords: FFaker::Name.name,
        meta_title: FFaker::Name.name,
        meta_description: FFaker::Name.name
      }
    }

    general_info {
      {
        title: FFaker::Name.name,
        price: '123',
        ratings: '321',
        image: 'image_text'
      }
    }
  end
end
