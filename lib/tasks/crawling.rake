namespace :crawling do
  desc 'crawl Amazon'
  task :amazon => :environment do
    Amazon::PrimeProduct::ScarpService.call
    Amazon::PrimeVideo::ScarpService.call
  end
end
