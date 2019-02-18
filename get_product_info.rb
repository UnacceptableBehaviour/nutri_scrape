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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def scrape_sainsburys html_page
  #SimpleNutrientInfo.new 'sainsburys', 1, {}
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Morrisons
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def get_morrison_ingredients
  # refactor
end

def scrape_morrisons html_page
  #SimpleNutrientInfo.new 'morrisons', 2, {}

  #a_product_name
  #a_price_per_package
  #a_price_per_measure
  #a_supplier_item_code
  #a_product_url
  #a_supplier_name
  #a_nutrition_info
  #a_ingredients
  #a_ingredients_text
  
  a_supplier_name = 'Morrisons'
  
  a_product_name = html_page.search(".//h1/strong[@itemprop='name']").text.strip 
  puts "\n\nPRODUCT NAME:        #{a_product_name} - #{a_supplier_name}"
  
  a_price_per_package = html_page.search(".//div[@class='typicalPrice']").text.strip
  puts "UNIT COST:           #{a_price_per_package}"

  # Package weight:    ? - can be derived from unit cost & price/100g

  a_price_per_measure = html_page.search(".//p[@class='pricePerWeight']").text.strip
  puts "PRICE PER WEIGHT:    #{a_price_per_measure}"
  
  a_supplier_item_code = '-199' # define magic number 
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  #get_morrison_ingredients
  a_ingredients_text = ''

  node_set = html_page.search(".//div[@class='bopSection']")

  get_this_node = false

  # get the node after 'Allergy Advice'
  node_set.search(".//p").each{ |node|
        
    if get_this_node

      a_ingredients_text = node.text

      break

    end

    # found allergy advice flag it
    get_this_node = true if node.text =~ /Allergy Advice:/

  }
  
  puts "INGREDIENTS:         #{a_ingredients_text}"
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # get_morrison_nutrition_info_per_100g
  # add a check for as prepared and other dodges
  table = html_page.at('table')
  
  a_symbol_to_regex = {
    :energy =>            /(\d+)\s*kcal/,      # $1 = kcal integer
    :fat =>               /fat/,
    :saturates =>         /saturates/,
    :mono_unsaturates =>  /mono/,
    :poly_unsaturates =>  /poly/,
    :omega_3 =>           /omega/,
    :carbohydrates =>     /carbohydrate/,
    :sugars =>            /sugars/,
    :starch =>            /starch/,
    :protein =>           /protein/,
    :fibre =>             /fibre/,
    :salt =>              /salt/,
    :alcohol =>           /alchol/
  }
  
  # add header titles
  #(CATEGORY_WIDTH+VALUE_WIDTH).times{ print "-"} ; puts
  #puts "Category".ljust(CATEGORY_WIDTH)+"Value".ljust(VALUE_WIDTH)
  #(CATEGORY_WIDTH+VALUE_WIDTH).times{ print "-"} ; puts
  
  nutrients = {}
  
  table.search('tr').each { |tr|
    title_column    = tr.children[0].text.downcase
    quantity_column = tr.children[1].text.downcase
    
    next if title_column =~ /typical/      # check here for 'as prepared'
    next if title_column =~ /reference/
    
    if quantity_column =~ a_symbol_to_regex[:energy]
      
      nutrients[:energy] = $1.to_i
      
    end

    a_symbol_to_regex.each_pair { |sym, regex|
              
      if title_column =~ regex
        
        quantity_column =~ /(\d+\.\d*)g/

        nutrients[sym] = $1.to_f.round(1)
        #puts "     SYM:#{sym.to_s} - #{regex.to_s} = qty:#{quantity_column} - $1 #{$1} <"
        
      end

    }
    
    #puts "#{tr.children[0].text}".ljust(CATEGORY_WIDTH)+"#{tr.children[1].text}".ljust(VALUE_WIDTH)    
  }
  #(CATEGORY_WIDTH+VALUE_WIDTH).times{ print "-"} ; puts
  
  a_nutrition_info = SimpleNutrientInfo.new  a_product_name, a_supplier_item_code, nutrients 
  
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def scrape_tesco html_page
  SimpleNutrientInfo.new 'tesco', 3, {}
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def scrape_waitrose html_page
  SimpleNutrientInfo.new 'waitrose', 4, {}
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def scrape_coop html_page
  SimpleNutrientInfo.new 'coop', 5, {}
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
def scrape_ocado html_page
  SimpleNutrientInfo.new 'ocado', 6, {}
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# top level get nutrient request
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
        'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-large-mango-%28each%29',
        'https://groceries.morrisons.com/webshop/product/Morrisons-Beef-Stock-Cubes-12s/265316011',           # beef stock cube
        'https://groceries.morrisons.com/webshop/product/Pilgrims-Choice-Extra-Mature-Cheddar/115520011',
        #'https://www.tesco.com/groceries/en-GB/products/294070184',                                           # red cabbage
        #'https://www.waitrose.com/ecom/products/waitrose-cooks-homebaking-baking-powder/650311-92314-92315',  # baking powder - info in drop down        
        #'https://food.coop.co.uk/',                                                        # requires a login - keep it simple
        # the occado web - this site looks identical to morrisons! ?
        #'https://www.ocado.com/webshop/product/Ocado-Green-Beans/81086011',                # green bean - no nutrition table
        #'https://www.ocado.com/webshop/product/Sunripe-Organic-Green-Beans/235313011',    # green bean - large nutrition table
        #'https://www.ocado.com/webshop/product/Essential-Waitrose-Round-Beans/18887011',  # green bean - small nutrition table
        
       ]


urls.each{ |url|
  puts ". . . . GETTING\n #{url}"
  
  product_info = get_product_info url
  
  puts product_info.to_s  
  
}
 
exit



puts;puts


#exit
#