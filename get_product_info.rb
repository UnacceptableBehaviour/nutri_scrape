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

300.times{ print '#'}
puts


def scrape_sainsburys html_page
  NutrientInfo.new 'sainsburys', 1, {}
end

def scrape_morrisons html_page
  NutrientInfo.new 'morrisons', 2, {}
end

def scrape_tesco html_page
  NutrientInfo.new 'tesco', 3, {}
end

def scrape_waitrose html_page
  NutrientInfo.new 'waitrose', 4, {}
end

def scrape_coop html_page
  NutrientInfo.new 'coop', 5, {}
end

def scrape_ocado html_page
  NutrientInfo.new 'ocado', 6, {}
end


def get_product_info url
  product_info = nil
  
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
  
  mech_agent.get(url)     # get page
  
  page = mech_agent.page
  
  
  supplier_regex = [  
    /(sainsburys)/,
    /(morrisons)/,
    /(tesco)/,
    /(waitrose)/,
    /(coop)/,
    /(ocado)/
  ]
  
  
  match = nil
    
  supplier_regex.each{ |regex|    
    url =~ regex
    
    match = $1
    
    break if $1    
  }

  
  # SAVE page for inspection
  local_copy_location = './z_data/mechanize/'
  
  retireved_page_name = "retievd_page_from_#{match}.html"
  
  File.open( File.join(local_copy_location,retireved_page_name ), 'w') { |file| file << page.body }
  # file automatically closed by block

  
  case match
    
  when 'sainsburys'
    product_info = scrape_sainsburys page
    
  when 'morrisons'
    product_info = scrape_morrisons page
    
  when 'tesco'
    product_info = scrape_tesco page
    
  when 'waitrose'
    product_info = scrape_waitrose page
    
  when 'coop'
    product_info = scrape_coop page
    
  when 'ocado'
    product_info = scrape_ocado page
  
  when nil
    product_info = scrape_specialist page
    
  end
    
  product_info
end




urls = ['https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-white-closed-cup-mushrooms-500g',          # white mushrooms
        'https://groceries.morrisons.com/webshop/product/Morrisons-Beef-Stock-Cubes-12s/265316011',           # beef stock cube
        'https://www.tesco.com/groceries/en-GB/products/294070184',                                           # red cabbage
        'https://www.waitrose.com/ecom/products/waitrose-cooks-homebaking-baking-powder/650311-92314-92315',  # baking powder - info in drop down        
        'https://food.coop.co.uk/',                                                        # requires a login - keep it simple
        # the occado web - this site looks identical to morrisons! ?
        #'https://www.ocado.com/webshop/product/Ocado-Green-Beans/81086011',                # green bean - no nutrition table
        'https://www.ocado.com/webshop/product/Sunripe-Organic-Green-Beans/235313011',    # green bean - large nutrition table
        #'https://www.ocado.com/webshop/product/Essential-Waitrose-Round-Beans/18887011',  # green bean - small nutrition table
        
       ]


urls.each{ |url|
  puts ". . . . GETTING\n #{url}"
  
  nutrients = get_product_info url
  
  puts nutrients.to_s
  
}
 
exit



puts;puts


#exit
#