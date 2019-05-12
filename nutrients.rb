#!/usr/bin/env ruby

#-------------------------------------------------------------------------------
#  Filename: nutrients.rb
#
#= Description - nutrient info class
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


#------------------ for the nutrition information food_name (per 100g)
#energy
#fat
#saturates
#mono-unsaturates
#poly-unsaturates
#omega_3
#carbohydrate
#sugars
#starch
#fibre
#protein
#salt
#alcohol
#											Total (100g)

# add a comment to get dif tool working

class SimpleNutrientInfo
  attr_accessor :name, :fda_db_no, :nutrients        
  
  def initialize ( name, product_name, id=-99, new_nutrients = {} )
    @generic_name = name
    @product_name = product_name
    @fda_db_no = id  # if not in the FDA DB include a url to product

    @nutrients = {
      :energy => 0.0,
      :fat => 0.0,
      :saturates => 0.0,
      :mono_unsaturates => 0.0,
      :poly_unsaturates => 0.0,
      :omega_3 => 0.0,
      :carbohydrate => 0.0,
      :sugars => 0.0,
      :starch => 0.0,
      :fibre => 0.0,
      :protein => 0.0,
      :salt => 0.0,
      :alcohol => 0.0
    }.merge new_nutrients
    
    
  end

  def to_s
    
    translate = {
      :energy           =>  'energy',
      :fat              =>  'fat',
      :saturates        =>  'saturates',    
      :mono_unsaturates =>  'mono-unsaturates',
      :poly_unsaturates =>  'poly-unsaturates',
      :omega_3_oil      =>  'omega_3_oil',        
      :carbohydrates    =>  'carbohydrates',
      :sugars           =>  'sugars',
      :starch           =>  'starch',
      :fibre            =>  'fibre',
      :protein          =>  'protein',    
      :salt             =>  'salt',
      :alcohol          =>  'alcohol'
    }
    
    #return_simplified_text = "------------------ for the nutrition information #{@name} (ndb_no=#{@fda_db_no})\n"
    return_simplified_text = "------------------ for the nutrition information #{@generic_name} (ndb_no=#{@fda_db_no})\n"
  
    translate.each_pair{ |symbol, text|
      
      return_simplified_text += "#{text}".ljust(16)+"\t\t\t"+"#{@nutrients[symbol].to_f.round(1)}".rjust(10)+"\n" unless @nutrients[symbol].to_f.round(1) == 0
      
    }
    
    pp @nutrients
    
    return_simplified_text += "\t\t\t\t\t\t\t\t\t\t\tTotal (100g)\n"
                
    #return_simplified_text
  end

end

#