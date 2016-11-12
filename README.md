### AskMeHow Ruby(Rails) project implemented with ActiveRecord, RSpec, Sphinx
### Description:

  Clasic Q/A

### Dependencies:
- Ruby 2.2.1
- PostgreSQL
- Sphinx
- Redis

### Installation:
   - Clone poject
   - Run bundler:

   ```shell
   $ bundle install
   ```
   Create database.yml:
   ```shell
   $ cp config/database.yml.sample config/database.yml
   $ bundle exec rake db:create db:migrate
   ```
   - Run application: #(please use different terminal tabs for each comand)
   ```shell
    $ rails s -p 3000
    $ rackup private_pub.ru -s thin -E production #(websocket actions)
    $ redis-server #(background jobs)
    $ sidekiq #(background jobs)
    $ rake ts:index ts:start #(indexes and starts the Sphinx)
   ```
   
   ##### Tests:

   To execute tests, run following commands:

   ```shell
    $ bundle exec rake db:migrate RAILS_ENV=test #(the first time only)
    $ bundle exec rspec
   ```

### License

The software is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).