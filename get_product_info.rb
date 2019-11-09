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


#require 'pp'

300.times{ print '#'}
puts



urls = {
          #'white mushrooms' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-white-closed-cup-mushrooms-500g',          # white mushrooms
          #'mango' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-large-mango-%28each%29',
          #'mrs beef stock cubes' => 'https://groceries.morrisons.com/webshop/product/Morrisons-Beef-Stock-Cubes-12s/265316011',           # beef stock cube
          #'extra mature cheddar' => 'https://groceries.morrisons.com/webshop/product/Pilgrims-Choice-Extra-Mature-Cheddar/115520011',
        #'sbs tinned butter beans' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-butter-beans-in-water-215g',
          #'sbs tinned chick peas' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-chickpeas-215g',
          #'ktc tinned plum tomatoes' => 'https://www.sainsburys.co.uk/shop/gb/groceries/ktc-peeled-plum-tomatoes-400g',
          # here per 100g in 2nd column - but per 100ml title in column 0 and 1 WTF!?
          #'sbs dark soy sauce' => 'https://www.sainsburys.co.uk/shop/gb/groceries/sainsburys-dark-soy-sauce-150ml',
          # here per 100g in 3rd column
          #'walker poppadoms mango chutney' => 'https://www.sainsburys.co.uk/shop/gb/groceries/walkers-sensations-poppadoms-mango---chutney-snacks-825g',
          #'yorkie' => 'https://www.sainsburys.co.uk/shop/gb/groceries/yorkie-46g',
          #'red cabbage' => 'https://www.tesco.com/groceries/en-GB/products/294070184',                                           # red cabbage
          
          #'tsc apple and raspberry juice' => 'https://www.tesco.com/groceries/en-GB/products/278994762',
          #'seeded panini' => 'https://www.tesco.com/groceries/en-GB/products/268580351',
          'beef monster munch' => 'https://www.sainsburys.co.uk/shop/gb/groceries/monster-munch-roast-beef-x6-25g', # comes back w/ 22g column not 100g
          #'mcV' => 'https://www.sainsburys.co.uk/shop/gb/groceries/mcvities-milk-chocolate-digestives-biscuits-332g',
          #'asda lamb rogan josh' => 'https://groceries.asda.com/product/indian-takeaway/asda-lamb-rogan-josh/910002599334',
          #'asda three cheese garlic flatbread' => 'https://groceries.asda.com/product/flatbreads-ciabatta/asda-three-cheese-garlic-flatbread/910002093229',          
          #'hs prawn crackers' => 'https://www.booker.co.uk/catalog/productinformation.aspx?code=247944',

          #'cava' => 'https://www.fatsecret.com/calories-nutrition/generic/spanish-cava-wine?portionid=4871975&portionamount=100.000',
          #'star anise' => 'https://www.fatsecret.com/calories-nutrition/usda/anise-seed?portionid=56595&portionamount=100.000',
          #'salmon' => 'https://www.fatsecret.com/calories-nutrition/generic/salmon-raw'

          #folllowing get incorrect info - energy wrong , has commas instead of full stops - spanish decimal
          #'chorizo' => 'https://groceries.morrisons.com/webshop/product/Elpozo-Iberico-Chorizo-Ring/456216011'

          #'flying goose hoisin sauce' => 'https://groceries.morrisons.com/webshop/product/Flying-Goose-Hoisin-Sauce/387755011',
        #
        #'' => 'https://www.waitrose.com/ecom/products/waitrose-cooks-homebaking-baking-powder/650311-92314-92315',  # baking powder - info in drop down        
        #'' => 'https://food.coop.co.uk/',                                                        # requires a login - keep it simple
        # the occado web - this site looks identical to morrisons! ?
        #'' => 'https://www.ocado.com/webshop/product/Ocado-Green-Beans/81086011',                # green bean - no nutrition table
        #'' => 'https://www.ocado.com/webshop/product/Sunripe-Organic-Green-Beans/235313011',    # green bean - large nutrition table
        #'' => 'https://www.ocado.com/webshop/product/Essential-Waitrose-Round-Beans/18887011',  # green bean - small nutrition table
}

new_problem_urls = {
    'cheese and onion crisps' => 'https://www.sainsburys.co.uk/shop/gb/groceries/walkers-cheese---onion-crisps-325g', # bag 32.5g instead of 100g comes back
    'cadburies darkmilk' => 'https://www.tesco.com/groceries/en-GB/products/301065629',  # nothing back
    'plain chocolate' => 'https://www.booker.co.uk/catalog/productinformation.aspx?code=247292&categoryName=306351',
    'tsc apple and raspberry juice' => 'https://www.tesco.com/groceries/en-GB/products/278994762', # nothing back
    'tsc seeded panini' => 'https://www.tesco.com/groceries/en-GB/products/268580351', # nothing back
    'mixed seaweed' => 'https://www.japancentre.com/en/products/3000-tokon-seaweed-salad-mix',
    'beef monster munch' => 'https://www.sainsburys.co.uk/shop/gb/groceries/monster-munch-roast-beef-x6-25g', # comes back w/ 22g column not 100g
}
#returns (the info for 32.5g bag)
#------------------ for the nutrition information cheese and onion crisps (ndb_no=https://www.sainsburys.co.uk/shop/gb/groceries/walkers-cheese---onion-crisps-325g)
#energy                           160.0
#fat                                8.7
#saturates                          0.7
#carbohydrates                     18.2
#sugars                             0.9
#fibre                              1.4
#protein                            1.8
#salt                               0.4
#Total (100g)
#
#should be:
#------------------ for the nutrition information cheese and onion crisps (ndb_no=https://www.sainsburys.co.uk/shop/gb/groceries/walkers-cheese---onion-crisps-325g)
#energy                           495.0
#fat                               27.6
#saturates                          2.1
#carbohydrates                     55.9
#sugars                             2.7
#fibre                              4.4
#protein                            5.6
#salt                               1.2
#Total (100g)



urls.each_pair{ |name, url|
  puts ". . . . GETTING\n #{url}"
  
  product_info = ProductInfo.new name, url
  
  puts product_info.nutrition_info.to_s
  
}
 
exit
