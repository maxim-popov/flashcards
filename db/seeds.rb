# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "nokogiri"
require "open-uri"
vocabulary = []
data = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))
data.xpath("//tr/td").each do |cell|
	if cell["class"] == "bigLetter"
  	original = cell.content.to_s
    translated = cell.next_element.content.to_s
    Card.create(original_text: original,translated_text: translated)
  end
end
