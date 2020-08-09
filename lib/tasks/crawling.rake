namespace :crawling do
  desc 'crawl Amazon'
  task :amazon => :environment do
    Amazon::PrimeProductScarpService.call
  end
end
