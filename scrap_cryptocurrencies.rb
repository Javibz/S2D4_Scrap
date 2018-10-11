require 'open-uri'
require 'nokogiri'


def scrap_crys_name(page)
	return page.css("a.currency-name-container.link-secondary")
end

def scrap_crys_value(page)
	return page.css("a.price")
end


def perform

	i=0
	while (true)
		url_crys = "https://coinmarketcap.com/all/views/all/"
		page_crys = Nokogiri::HTML(open(url_crys))
	
		array_crys_name = scrap_crys_name(page_crys)
		array_crys_value = scrap_crys_value(page_crys)
	
		hash_crys = Hash.new
	
	
		array_crys_name.each_with_index do |cry_name, index|
			hash_crys[cry_name.text] = array_crys_value[index].text
		end
	
		puts hash_crys

		puts "Number of loop : #{i}"
		i+=1

		sleep(3600)
	end

end


perform
