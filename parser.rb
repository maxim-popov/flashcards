require 'nokogiri'
require 'open-uri'
data = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))
vocabulary = [[]]
data.xpath("//tr/td").each do |cell|
	if cell["class"] == "bigLetter"
		original_text = cell.content.to_s
		translated_text = cell.next_element.content.to_s
		vocabulary = vocabulary << [[original_text,translated_text]]
	end
end

vocabulary.each do |o.to_s,s.to_s|
	puts o
end