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

puts "I AM the nutrients!"

n = NutrientInfo.new 'sour dough ring loaf', 8050602, {}

puts n.to_s

exit
#