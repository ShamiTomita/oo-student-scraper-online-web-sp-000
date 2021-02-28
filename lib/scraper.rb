require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    student_profile = []
    page.css('div.student-card').each do |profile|
      student_profile << {
      :name => profile.css("h4.student-name").text,
      :location => profile.css("p.student-location").text,
      :profile_url => profile.children[1].attributes["href"].value
      }
    end
    student_profile
  end
  
  

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    student = {}
    
      social = page.css(".vitals-container .social-icon-container a")
      
      student[:profile_quote] = page.css("div.profile-quote").text
      student[:bio] = page.css("p").text
      student
  end
end

