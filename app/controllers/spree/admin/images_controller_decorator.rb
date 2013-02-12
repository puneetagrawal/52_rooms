module Spree
  module Admin
   ImagesController.class_eval do
   	before_filter [:f2r_data,:load_data]
  include Spree::ProductsHelper
private
 def load_data
         
          @product = Product.where(:permalink => params[:product_id]).first
          @variants = @product.variants.collect do |variant|
            [variant.options_text, variant.id]
          end
          @variants.insert(0, [I18n.t(:all), @product.master.id])
           p @variants
          p '////////////////variants//////////////////'        
          @f2r_hotel_inventories = @product.f2r_hotel_inventory_items.collect do |inv|
            [get_option_value(inv.room_type),inv.id]
          end
          @f2r_hotel_inventories.insert(0, [I18n.t(:all), @product.master.id])

         p @f2r_hotel_inventories
          p '////////////////f2r_hotel_inventories//////////////////'
          
        end 

       
 def f2r_data
          @product = Product.where(:permalink => params[:product_id]).first
          @f2r_hotel_inventories = @product.f2r_hotel_inventory_items.collect do |inv|
            [Spree::Product.get_option_value(inv.room_type).name,inv.room_type]
          end
          @f2r_hotel_inventories.insert(0, [I18n.t(:all), @product.master.id])

         p @f2r_hotel_inventories
          p '////////////////f2r_hotel_inventories//////////////////'

        end

  
   end
   end
   end
