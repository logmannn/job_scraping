require ('pry')

class Job < ActiveRecord::Base

  def indeed_link(params)
    "https://www.indeed.com/jobs?q=#{params[:query]}&l=#{params[:city]}%2C+#{params[:state]}&explvl=#{params[:level]}&radius=#{params[:distance]}"
  end

  def craigslist_link(params)
    "https://#{params[:city]}.craigslist.org/search/jjj?query=#{params[:query]}&sort=rel&search_distance=#{params[:distance]}"
  end

  def self.scrape_indeed(link)
    page = Nokogiri::HTML(open("#{link}"))

    #amount of jobs to get page amounts
    number_of_jobs = page.css('#searchCount').to_s
    if number_of_jobs == ""
      return false;
    end
    number_of_jobs =~ /Page 1 of (.*?) jobs/
    number_of_jobs = $1.gsub(/\,/, '')
    if number_of_jobs.to_i == 0
      return false
    end
    number_of_pages = (number_of_jobs.to_i/14) + 1
    number_of_pages.times do |i|
      page = Nokogiri::HTML(open("#{link}&start=#{i*10}"))
      page.css('.row').each do |job|
        title = job.css('.jobtitle').text
        company = (job.css('.company').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        summary = (job.css('.summary').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        days_posted = (job.css('.date').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        location = (job.css('.location').text).gsub(/^\s+|\s+$|\s+(?=\s)/, '')
        link = "https://www.indeed.com" + job.css('a')[0]["href"]
        # job.css('a')[0]["href"]
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location, :link => link, :pinned => false})
      end
    end
  end

  def self.scrape_craigslist(link)
    page = Nokogiri::HTML(open("#{link}"))
    #amount of jobs to get page amount
    number_of_jobs = (page.css('.totalcount').first).to_s
    if number_of_jobs == ""
      return false;
    end
    amount_of_jobs = (((page.css('.totalcount').first).text).to_s).to_i
    amount_of_pages = ((amount_of_jobs.to_f)/120).ceil
    amount_of_pages.times do |i|
      page = Nokogiri::HTML(open("#{link}#{i*120}&sort=rel"))
      (page.css('.result-info')).each do |job|
        title = job.css('.result-title').text
        company = ""
        summary = ""
        days_posted = (job.css('.result-date').text).gsub(/[\(\)]/, '')
        location = (job.css('.result-hood').text).gsub(/[\(\)]/, '')
        link = job.css('a')[0]["href"]
        Job.create({:title => title, :company => company, :summary => summary, :days_posted => days_posted, :location => location, :link => link})
      end
    end
  end
end
