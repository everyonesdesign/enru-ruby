#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require 'cgi'

word = ARGV[0]

if word

	#escape word if it's cyrillic of contains some spec symbols
	word = CGI.escape word

	page = Nokogiri::HTML(open("https://slovari.yandex.ru/#{word}/%D0%BF%D0%B5%D1%80%D0%B5%D0%B2%D0%BE%D0%B4/"))

	title = page.css('.b-translation__title')[0]
	groups = page.css('.b-translation__group')

	if title

		title.traverse do |item|
			classAttr = item['class']

			if classAttr
				if classAttr.include? 'b-translation__text'
					puts item.to_s.gsub!(/<.*?>/, '').bold
				elsif classAttr.include? 'b-translation__tr'
					puts item.to_s.gsub!(/<.*?>/, '').blue
				end
			end
		end

		groups.each do |group|
			group.traverse do |item|
				classAttr = item['class']

				if classAttr
					if classAttr.include? 'b-translation__translation-words'
						puts item.to_s.gsub!(/<.*?>/, '')
					elsif classAttr.include? 'b-translation__group-title'
						puts "\n"
						puts item.to_s.gsub!(/<.*?>/, '').yellow
					end
				end
			end
		end

	else

		puts 'Nothing found'.red
		puts 'Try something different'

	end

else

	puts 'Type a search'.red

end
