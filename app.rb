require("bundler/setup")
require("pry")
require("open-uri")
# require("./lib/meetup.rb")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }



MeetupClient.configure do |config|
  config.api_key = "48216d5851293b1f446a235e597c3b"
end

meetup_api = MeetupApi.new

get('/meetup_test') do
  Meetup.where(pinned: false).destroy_all

  meetup_params = { category: '34',
    city: 'Portland',
    state: 'OR',
    country: 'US',
    status: 'upcoming',
    format: 'json',
    page: '50'}
  @events = meetup_api.open_events(meetup_params)

  @events["results"].each do |event|
    meetup_attributes = {}
    meetup_attributes["utc_offset"] = event["utc_offset"]
    meetup_attributes["time"] = event["time"]
    meetup_attributes["event_url"] = event["event_url"]
    meetup_attributes["name"] = event["name"]
    meetup_attributes["description"] = event["description"]
    meetup_attributes["yes_rsvp_count"] = event["yes_rsvp_count"]
    meetup_attributes["status"] = event["status"]

    if event["venue"]
      meetup_attributes["venue_name"] = event["venue"]["name"]
      meetup_attributes["venue_city"] = event["venue"]["city"]
      meetup_attributes["venue_state"] = event["venue"]["state"]
      meetup_attributes["venue_zip"] = event["venue"]["zip"]
      meetup_attributes["venue_country"] = event["venue"]["country"]
      meetup_attributes["venue_address_1"] = event["venue"]["address_1"]
    end

    if event["group"]
      meetup_group_attributes = {}
      meetup_group_attributes["name"] = event["group"]["name"]
      meetup_group_attributes["group_url"] = "https://www.meetup.com/#{event["group"]["urlname"]}"

      meetup_group = MeetupGroup.find_or_create_by(meetup_group_attributes)

      meetup_attributes["group_id"] = meetup_group.id
    end

    meetup_attributes["pinned"] = false

    Meetup.create(meetup_attributes)
  end
  @meetups = Meetup.all
  erb(:meetup_test)
end

get("/scrape") do
  @link = "https://www.indeed.com/jobs?q=jr+developer&l=Portland%2C+OR"
  Job.scrape(@link)
  erb(:scrape)
end

get("/home") do
  @meetups = Meetup.all
  erb(:home)
end