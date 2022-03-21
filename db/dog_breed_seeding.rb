require 'nokogiri'
require 'open-uri'

def seed_dog_breeds
  doc = Nokogiri::HTML(URI.open('https://dogtime.com/dog-breeds/profiles'))

  groups = doc.css('.group-letter')

  groups.each do |letter|
    letter.css('.list-item').each do |item|
      Breed.create(name: item.css('a')[1].text.strip.downcase)
    end
  end
end
