require ('pry')

class Job < ActiveRecord::Base
  def self.scrape(link)
    page = Nokogiri::HTML(open("#{link}"))

    #amount of jobs to get page amounts
    number_of_jobs = page.css('#searchCount').to_s
    number_of_jobs =~ /Page 1 of (.*?) jobs/
    number_of_jobs = $1.gsub(/\,/, '')
    number_of_pages = (number_of_jobs.to_i/14)
    page_stuff = []
    number_of_pages.times do |i|
      page = Nokogiri::HTML(open("#{link}&start=#{i*10}"))
      page.css('.row').each do |job|
        title = job.css('.jobtitle').text
        company = (job.css('.company').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        summary = (job.css('.summary').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        days_posted = (job.css('.date').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        location = (job.css('.location').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        binding.pry
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location})
      end
    end

  end
end
