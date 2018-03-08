# job_search

#### by Russell Hofvendahl, Chase Bowden, Logan Tanous and Ron Craig
#### Ruby week 5 group project

### GitHub repository:

## Description
### An app using Active Reader, ruby, rubygems, web scraping, BDD, Sinatra and CRUD routing to search multiple job and social sites (meetup, indeed, craiglist, etc.) for a software developer job and networking events.  A user can simultaneously search for a job and find events to attend for networking.  There is also an opportunity to gather information about attendees or speaker at the event.

## Specifications
### Back end specs: class Job
1. Retrieve search results from LinkedIn, craigslist (CL), and TBD.
2. Use Nokogiri gem to scrape results from CL


### Back end specs: class MeetupGroup
1. Join relationship between Meetup and Meetup Groups (MeetupGroup has_many Meetups).
2. Validates the MeetupGroup name is unique.


### Back end specs: class Meetup
1. Join relationship between Meetup and Meetup Groups (Meetup belongs_to MeetupsGroup).
2. Validates the Meetup name is unique.

### Front end specs: Sinatra and user stories
1. A user should be able to perform a job search by inputting the following...
* Languages
* Location
* Experience level (Entry, Intermediate, Senior)
* Search Radius
2. A user should be able to view results (jobs and suggested meetings).
3. A user should be able to pin favorite jobs and or favorite meetups.
4. A user should be able to select a link to view more details about the job/meeting.
5. A user should be able to associate the job with meetups in the area. (ongoing)
6. A user should be able to associate a meetup event with event leader or attendee at the event, for networking purposes. (ongoing)
7. A user should be able to view the event leader or attendee LinkedIn profile, for networking purposes. (ongoing)

## Setup/Instructions
### Install Sinatra Active Reader
* ($ gem install sinatra-activerecord)
### Install rake
* ($ gem install rake)
### Create and edit (1) Gemfile and (2) Rakefile in the project's root directory
### Install rubygems (Rspec, pry, Capybara and Sinatra).  In the project's root directory...
* Install gem bundler ($ gem install bundler; $ bundle install; $ bundle update)
### Install Postgres.  Open another terminal window, go to home directory ($ cd ~)...
* Install Postgres ($ gem install pg)
* Open Postgres ($ psql)

## Known Bugs
### TBD

## Technology used
* Ruby, Sinatra and shoulda-matchers (application)
* LinkedIn API TBD (application)
* Active Record and Rake (database and application)
* Rspec and Capybara (testing)

### MIT License

Copyright (c) 2018 **_Taking_Care_of_Business_Productions_**
