#https://www.indeed.com/jobs?q=css&l=portland%2C+OR&explvl=entry_level&radius=15

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

get('/test') do
  meetup_params = { group_id: 22875093,
    format: 'json',
    page: '50'}
  @members = meetup_api.members(meetup_params)

  @members["results"].each do |member|
    member_attributes = {}
    member_attributes["name"] = member["name"]
    member_attributes["city"] = member["city"]
    member_attributes["state"] = member["state"]
    member_attributes["country"] = member["country"]
    # member_attributes["linkedin_user_id"] = member["description"]
    MeetupMember.create(member_attributes)
  end
  @meetup_members = MeetupMember.all
  binding.pry
  erb(:test)
end

get('/') do
  @meetups = Meetup.all
  @jobs = Job.all
  erb(:home)
end

#do job stuff in here?
post('/') do
  Meetup.all.each do |meetup|
    if params["#{meetup.id}"] == "pinned"
      meetup.update({pinned: true})
    else
      meetup.destroy
    end
    languages = params[:item].inspect
    location = params.fetch("location")
    distance = params.fetch("distance")
    level = params.fetch("level")



  end
  # Meetup.where(pinned: false).destroy_all

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

    Meetup.create(meetup_attributes)
  end
  @meetups = Meetup.all
  erb(:home)
end

get('/meetups/:meetup_id') do
  @meetup = Meetup.find(params[:meetup_id])
  erb(:meetup_detail)
end

get('/jobs/:job_id') do
  erb(:job_detail)
end

get("/scrape") do
  city = "portland"
  state = ("or").upcase
  query = "javascript+developer"
  @link = "https://www.indeed.com/jobs?q=#{query}&l=#{city}%2C+#{state}"
  Job.scrape_indeed(@link)

  @link = "https://#{city}.craigslist.org/search/jjj?query=#{query}&s=0&sort=rel"
  Job.scrape_craigslist(@link)
  erb(:scrape)
end
