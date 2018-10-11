require 'open-uri'
require 'nokogiri'

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))

puts page.css("tr")[4].text
