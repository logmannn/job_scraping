ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')
require "./lib/job"

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Meetup.all().each() do |meetup|
      meetup.destroy()
    end

    MeetupGroup.all().each() do |meetup_group|
      meetup_group.destroy()
    end
  end
end

#ADD SHOULDA MATCHER
