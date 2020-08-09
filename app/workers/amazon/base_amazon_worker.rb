
class Amazon::BaseAmazonWorker
  include Sidekiq::Worker

  MAIN_DOMAIN = 'https://www.amazon.com'
end
