#!/usr/bin/env ruby

#-------------------------------------------------------------------------------
#  Filename: get_product_info.rb
#
#= Description - scrape supermarket websites for product information 
#
#-------------------------------------------------------------------------------
#  Vs   Auth  Date    Comments
#-------------------------------------------------------------------------------
# 0.01  sf    26Apr17 Created
#-------------------------------------------------------------------------------
# TODO
#
#
#
#
#-------------------------------------------------------------------------------
require 'rubygems'
require 'nutrients'

# Following is a simple script to scrape information from Sainsburys website to fill a
# Nutrition object with data about a particular product.
# If we can gets cost info too that's a bonus
# 
# Create an agent with Mechanize.new, do a little setup, and scrape away!
# 
# The test url - tortilla chips
# 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-tortilla-chips--cool-salted-200g'
# 
# ---= What we want from page =---
# 
# Product name:   "Sainsbury's Tortilla Chips Salted 200g"
# UNIT COST:      "95p/unit"
# Unit weight:    ? - can be derived from unit cost & price/100g
# price per 100g: "48p/100g"
# Item code:      "1294231"
# Nutrition info / 100g
# INGREDIENTS:ÊMaize, Sunflower Oil, Toasted Maize Germ, ÊSalt.

require 'nokogiri'  # http://ruby.bastardsbook.com/chapters/html-parsing/
require 'open-uri'
require 'mechanize'
require 'logger'
#require 'pp'


# wrap page get with exception handling
def get_page_with_nokogiri(page_url)

  begin
    page = Nokogiri::HTML(open(page_url))
  rescue => e
    puts e.backtrace.class
    puts "inspecting"
    puts e.inspect
    puts "--------"
    puts e.message
    puts e.backtrace.last
    sleep(10)
    retry
  end

end



mech_agent = Mechanize.new { |agent|
  agent.log = Logger.new "./z_data/mechanize/mechanize.log"
  agent.history.clear
  agent.redirect_ok = true  
  agent.follow_meta_refresh = true
  agent.keep_alive = true
  agent.open_timeout = 30
  agent.read_timeout = 30  
  # pp Mechanize::AGENT_ALIASES # show list of agents - no mac chrome!
  agent.user_agent_alias = 'Mac Safari'
}




url = 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-white-closed-cup-mushrooms-500g'
puts ". . . . GETTING\n #{url}"

mech_agent.get(url)
puts;puts

# This now contains the HTML mech_agent.page.body - VIEW HTML IN CHROME
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# SAVE page for inspection
local_copy_location = './z_data/mechanize/'
File.open(File.join(local_copy_location,'page_load_PRE_sbs.html'), 'w') {|file| file << mech_agent.page.body }












n = NutrientInfo.new 'sour dough ring loaf', 8050602, {}

puts n.to_s

exit
#