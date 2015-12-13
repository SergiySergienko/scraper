Installation
1. Install and run PostgreSql
2. bundle install
3. Update credentials in database.yml
4. rake db:migrate
5. In terminal 'bundle exec sidekiq -c 10'
5. rake bloomberg_scraper:fetch_data
6. Wait till scraper complete fetching
7. 'rails server'