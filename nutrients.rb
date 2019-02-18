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

puts "included< nutrients.rb >"

class SimpleNutrientInfo
  attr_accessor :name, :fda_db_no, :nutrients        
  
  def initialize (name, id=-99, table = nil, new_nutrients = {} )
    @name = name
    @fda_db_no = id
    @table = table

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
    
    self.process_table
    
    #@table = nil
    
  end

  def process_table
    
    return if @table.nil?
    
    symbol_to_regex = {
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
    
    @table.search('tr').each { |tr|
      title_column    = tr.children[0].text.downcase
      quantity_column = tr.children[1].text.downcase
      
      next if title_column =~ /typical/      # check here for 'as prepared'
      next if title_column =~ /reference/
      
      if quantity_column =~ symbol_to_regex[:energy]
        
        @nutrients[:energy] = $1.to_i
        
      end

      symbol_to_regex.each_pair { |sym, regex|
                
        if title_column =~ regex
          
          quantity_column =~ /(\d+\.\d*)g/
  
          @nutrients[sym] = $1.to_f.round(1)
          #puts "     SYM:#{sym.to_s} - #{regex.to_s} = qty:#{quantity_column} - $1 #{$1} <"
          
        end

      }
      
      #puts "#{tr.children[0].text}".ljust(CATEGORY_WIDTH)+"#{tr.children[1].text}".ljust(VALUE_WIDTH)    
    }
    #(CATEGORY_WIDTH+VALUE_WIDTH).times{ print "-"} ; puts
    
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
    
    return_simplified_text = "------------------ for the nutrition information #{@name} (ndb_no=#{@fda_db_no})\n"
  
    translate.each_pair{ |symbol, text|
      
      return_simplified_text += "#{text}".ljust(16)+"\t\t\t"+"#{@nutrients[symbol].to_f.round(1)}".rjust(10)+"\n" unless @nutrients[symbol].to_f.round(1) == 0
      
    }
    
    return_simplified_text += "\t\t\t\t\t\t\t\t\t\t\tTotal (100g)\n"
            
    #return_simplified_text
  end

end

#