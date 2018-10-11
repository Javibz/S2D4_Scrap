require 'open-uri'
require 'nokogiri'

page1 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))

def get_the_email_of_a_townhal_from_its_webpage(page)
  return page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
end

page2 = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

def get_all_the_urls_of_val_doise_townhalls(links)
  hash = Hash.new
  vo_communes = links.css("a.lientxt")
  vo_communes.each do |commune|
      url_ville = "http://annuaire-des-mairies.com" + commune["href"][1..-1]
      hash[commune.text] = url_ville
  end
  return hash
end

hash_vo_communes = get_all_the_urls_of_val_doise_townhalls(page2)

tab_final = []

hash_vo_communes.each do |ville, url|
  page = Nokogiri::HTML(open(url))
  email = get_the_email_of_a_townhal_from_its_webpage(page)
  hash_ville_email = Hash.new
  hash_ville_email[ville] = email
  tab_final << hash_ville_email
end

puts tab_final
