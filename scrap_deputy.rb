require 'open-uri'
require 'nokogiri'


def scrap_deputys(page)
    #Select the <a> wich cointain all deputys :
    deputys = page.xpath('//*[@id="deputes-list"]/div/ul/li/a')

    hash_deputys = Hash.new
    deputys.each do |deputy|
        #Build deputy url and put it in a hash 
        hash_deputys[deputy.text] = "http://www2.assemblee-nationale.fr" + deputy['href']
    end
    return hash_deputys
end

def scrap_email(page)
    #Find all the <a> which contain deputy's details:
    deputy_as = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd/ul/li/a')

    #Select the <a> wich cointain deputy's email :
    email = ""
    deputy_as.each do |a|
        if a['href'].include?("mailto")
            email=a['href'].delete "mailto:" 
        end
    end
    return email
end


def perform

    url_deputys = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
    page_deputys = Nokogiri::HTML(open(url_deputys))

    hash_deputys = scrap_deputys(page_deputys)
    puts "NUMBER OF DEPUTYS : #{hash_deputys.length}"

    hash_deputys_emails = Hash.new
    hash_deputys.each do |name, url|
        page_deputy = Nokogiri::HTML(open(url))
        email = scrap_email(page_deputy)
        puts "#{name} email is : #{email}"
        hash_deputys_emails[name]=email
    end
    #Display hash wich contain all deputys and their email
    puts hash_deputys_emails

end


perform

