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
require 'product_info'

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



urls = { 'white mushrooms' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-white-closed-cup-mushrooms-500g',          # white mushrooms
         'mango' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-large-mango-%28each%29',
         'mrs beef stock cubes' => 'https://groceries.morrisons.com/webshop/product/Morrisons-Beef-Stock-Cubes-12s/265316011',           # beef stock cube
         'extra mature cheddar' => 'https://groceries.morrisons.com/webshop/product/Pilgrims-Choice-Extra-Mature-Cheddar/115520011',
        #'' => 'https://www.tesco.com/groceries/en-GB/products/294070184',                                           # red cabbage
        #'' => 'https://www.waitrose.com/ecom/products/waitrose-cooks-homebaking-baking-powder/650311-92314-92315',  # baking powder - info in drop down        
        #'' => 'https://food.coop.co.uk/',                                                        # requires a login - keep it simple
        # the occado web - this site looks identical to morrisons! ?
        #'' => 'https://www.ocado.com/webshop/product/Ocado-Green-Beans/81086011',                # green bean - no nutrition table
        #'' => 'https://www.ocado.com/webshop/product/Sunripe-Organic-Green-Beans/235313011',    # green bean - large nutrition table
        #'' => 'https://www.ocado.com/webshop/product/Essential-Waitrose-Round-Beans/18887011',  # green bean - small nutrition table
}


urls.each_pair{ |name, url|
  puts ". . . . GETTING\n #{url}"
  
  product_info = ProductInfo.new name, url
  
  puts product_info.nutrition_info.to_s
  
}
 
exit



puts;puts


#exit
#