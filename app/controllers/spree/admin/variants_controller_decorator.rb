module Spree
  module Admin
   VariantsController.class_eval do
    require 'spreadsheet'
	# before_filter [:create_before,:new_before]
	def create
    # invoke_callbacks(:create, :before) 
    option_values = params[:new_variant] 
    option_id=""
    option_values.each_value {|id|
      option_id=id
    }      
    prod=Product.find_by_permalink(params[:product_id])
    if prod.product_type=='Coupon'
      super
    else 

      base_prod=prod.id
      f2r_inventory_item=prod.f2r_hotel_inventory_items.where(:room_type=>option_id).first
      variant=Spree::Variant.create :product_id => base_prod,
      :f2r_hotel_inventory_item_id=>f2r_inventory_item.id,
      :count_on_hand=>f2r_inventory_item.count_on_hand,
      :f2r_available_on=>"#{params[:variant]['available_on(1i)']}-#{params[:variant]['available_on(2i)']}-#{params[:variant]['available_on(3i)']}",
      :price=>params[:variant]["price"],
      :cost_price=>params[:variant]["cost_price"] ,
      :option_value_id=>option_id

      if !variant.blank? and !variant.errors.any?      
        variant.option_values << OptionValue.find(option_id)     
        flash.notice = flash_message_for(variant, :successfully_created)
        respond_with(variant) do |format|
          format.html { redirect_to location_after_save }
          format.js   { render :layout => false }
        end      
      else      
        set_flash_message(variant)     
        respond_with(variant)
      end

    end
  end


  def create_variant_xls

    prod=Product.find_by_permalink(params[:product_params])
    year=""
    month=""
    option_id=''
    f2r_inventory_item=''
    book= Spreadsheet.open(params[:variant][:excel_file].path)   
     # book.worksheets.each do |ws|
     # p ws[0,0]
     # end
     # p '::::::::::::::::::::::::::'
     # sfsdfsdfsdfds
    sheet= book.worksheet 0  
    temp=3
    column_length=sheet.row(1).length
    begin
      unless sheet[1,temp].blank?
        option_value=Spree::OptionValue.where("lower(name) = ?", sheet[1,temp].downcase).first       
        unless option_value.blank?
          option_id=option_value.id
          f2r_inventory_item=prod.f2r_hotel_inventory_items.where(:room_type=>option_id).first
          if f2r_inventory_item.blank?
           f2r_inventory_item= prod.f2r_hotel_inventory_items.create(:room_type=>option_id,:count_on_hand=>sheet[4,temp+1])
          end

        end
      end 
      sheet.each 3 do |row|
        if !row[0].blank? 
          year=row[0]
          month=row[1]
          date=1
        end
        unless row[temp].blank?
          if date!=1
            date=row[2].value.to_i 
          end      
          variant_date=DateTime.new(year,month,date)        
          avail_variant= Spree::Variant.where(:f2r_available_on=>variant_date,:product_id=>prod.id,:option_value_id=>option_id).first
          if !avail_variant.blank? and !f2r_inventory_item.blank?
            variant=avail_variant.update_attributes(
              :price=>row[temp],   
              :cost_price=>row[temp],
              :count_on_hand=>row[temp+1], 
              )     
          elsif !f2r_inventory_item.blank?
           variant=Spree::Variant.create :product_id => prod.id,
           :f2r_hotel_inventory_item_id=>f2r_inventory_item.id,
           :count_on_hand=>row[temp+1], 
           :f2r_available_on=>variant_date ,
           :price=>row[temp],
           :cost_price=>row[temp],
           :option_value_id=>option_id
           if !variant.blank? and ! variant.errors.any?      
            variant.option_values << OptionValue.find(option_id)     
          end
        end
      end

    end
    temp=temp+3
  end while temp<=column_length

  redirect_to "/admin/products/#{params[:product_params]}/variants"
end







	 # protected

  #       def create_before
  #         option_values = params[:new_variant] 

  #         option_values.each_value {|id|           
  #           @object.option_values << OptionValue.find(id)
  #            # @object.f2r_hotel_inventory_item_id=id
  #         }          
  #         # base_prod=Product.find_by_permalink(params[:product_id]).id         
  #         # @object.f2r_available_on="#{params[:variant]['available_on(1i)']}-#{params[:variant]['available_on(2i)']}-#{params[:variant]['available_on(3i)']}"
  #         # @object.product_id=base_prod
  #         # @object.save
  #       end
  #          def new_before
  #         @object.attributes = @object.product.master.attributes.except('id', 'created_at', 'deleted_at',
  #                                                                       'sku', 'is_master', 'count_on_hand')

  #       end

  def set_flash_message(object)
   unless object.errors.full_messages.empty?
     error_message=''
     object.errors.full_messages.each do |msg|
       error_message += "<div>#{msg}</div>"
     end
     flash[:error]  = error_message.html_safe
   end
 end


end
end
end
