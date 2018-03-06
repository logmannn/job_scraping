require ('pry')

class Job < ActiveRecord::Base
  def self.scrape_indeed(link)
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
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location})
      end
    end
  end

  def self.scrape_craigslist(link)
    page = Nokogiri::HTML(open("#{link}"))

    amount_of_jobs = ((@page.css('.totalcount').first).text).to_s
    amount_of_pages = (@amount_of_jobs.to_i)/120
    @linkmod = "https://portland.craigslist.org/search/jjj?query=#{@query}&s="
    @page_stuff = []
    amount_of_pages.times do |i|
      @page = Nokogiri::HTML(open("#{@linkmod}#{i*120}&sort=rel"))
      (@page.css('.result-info')).each do |job|
        title = job.css('.result-title').text
        company = ""
        summary = ""
        days_posted = (job.css('.result-date').text).gsub(/[\(\)]/, '')
        location = (job.css('.result-hood').text).gsub(/[\(\)]/, '')
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location})
      end
    end




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
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location})
      end
    end
  end
end
