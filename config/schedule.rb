#start all crawlings for amazon
every :monday, at: '10am' do
  rake "crawling:amazon"
end

# we can start specific crawl service
# every :monday, at: '10am' do
#   runner "Amazon::PrimeProduct::ScarpService.call"
# end

# every :monday, at: '10am' do
#   runner "Amazon::PrimeVideo::ScarpService.call"
# end

# if we use docker we can make settings like this
# labels:
#   deck-chores.perform-amazon-crawling.command: /bin/bash -c "cd /app && bundle exec rake crawling:amazon"
#   deck-chores.perform-amazon-crawling.cron: '0 10 * * 1'
#   deck-chores.perform-amazon-crawling.timezone: 'Europe/Moscow'
