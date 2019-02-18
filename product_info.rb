#!/usr/bin/env ruby

#-------------------------------------------------------------------------------
#  Filename: product_info.rb
#
#= Description - product info class
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

require 'nutrients.rb'

puts "included< product_info.rb >"

class ProductInfo
  attr_accessor :product_name,
                :price_per_package,     # could be one could be pack of 6!
                :price_per_measure,
                :supplier_item_code,
                :product_url,
                :supplier_name,
                :nutrition_info,
                :ingredients,
                :ingredients_text
                
   def initialise name, nutri_data = {}
     @product_name        = name
     @price_per_package   = 0.0
     @price_per_measure   = 0.0
     @supplier_item_code  = ''
     @product_url         = ''
     @supplier_name       = ''
     @nutrition_info      = SimpleNutrientInfo.new name, @supplier_item_code, nutridata
     @ingredients         = {}            # 'ingredient' => 1 or { sub_ingredients }
     @ingredients_text    = ''
   end   
end

CATEGORY_WIDTH = 24
VALUE_WIDTH = 10