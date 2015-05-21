#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'colorize'

word = ARGV.join(' ')

if word

	page = Nokogiri::HTML(open("https://slovari.yandex.ru/#{word}/%D0%BF%D0%B5%D1%80%D0%B5%D0%B2%D0%BE%D0%B4/"))

	title = page.css('.b-translation__title')[0]
	groups = page.css('.b-translation__group')

	if title

		title.traverse do |item|
			classAttr = item['class']

			if classAttr
				if classAttr.include? 'b-translation__text'
					puts item.to_s.gsub!(/<.*?>/, '').red
				elsif classAttr.include? 'b-translation__tr'
					puts item.to_s.gsub!(/<.*?>/, '').green
				elsif classAttr.include? 'b-translation__group-title'
					puts item.to_s.gsub!(/<.*?>/, '').green
				end
			end
		end

		puts "\n"

		groups.each do |group|
			group.traverse do |item|
				classAttr = item['class']

				if classAttr
					if classAttr.include? 'b-translation__translation-words'
						puts item.to_s.gsub!(/<.*?>/, '')
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
