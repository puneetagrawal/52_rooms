module Spree
  OrdersController.class_eval do
    def update
      @order = current_order
      if @order.update_attributes(params[:order])
        if @order.coupon_code.present?
          if apply_coupon_code
            flash[:notice] = t(:coupon_code_applied)
          else
            flash[:error] = t(:promotion_not_found)
            render :edit and return
          end
        end
        @order.line_items = @order.line_items.select {|li| li.quantity > 0 }
        fire_event('spree.order.contents_changed')
        respond_with(@order) { |format| format.html { redirect_to cart_path } }
      else
        respond_with(@order)
      end
    end
    
    def apply_coupon_code
      return if @order.coupon_code.blank?
      if Spree::Promotion.exists?(:code => @order.coupon_code)
        fire_event('spree.checkout.coupon_code_added', :coupon_code => @order.coupon_code)
        true
      end
    end
    
    # def edit
    #   @order = current_order(true)
    #   associate_user
    # end
    
    def populate_f2r
      @order = current_order(true)     
      # # "dates" => "2012-12-28,2012-12-30"
      # dates_arr = params[:order][:dates].split(',')
      check_in_date = DateTime.parse params[:order][:check_in_date]
      check_in = check_in_date;
      check_out_date = DateTime.parse params[:order][:check_out_date]
      diff = (check_out_date - check_in_date).to_i

       diff.times  do |diff_days|
         date_str = (check_in_date + (diff_days-0)).strftime('%Y-%m-%d')
        quantity = params[:order][:qty].to_i || 1
        v = Spree::Variant.find(:first, :conditions => {:f2r_available_on => date_str, 
        :option_value_id => params[:order][:room_type_id],:product_id=>params[:order][:product_id]})
        product_id = params[:order][:product_id]
        f2r_hotel_inventory_item_id = params[:order][:room_type_id]
        check_out_date = check_in + 1;
        @order.add_variant(v, quantity, check_in, check_out_date, product_id, f2r_hotel_inventory_item_id) if v
        check_in = check_in + 1;
        
=begin
        diffqty = (params[:order][:qty]).to_i

        o = Spree::Order.find(@order);
        o.product_id = params[:order][:product_id];
        o.quantity = o.quantity + diffqty;
        o.f2r_hotel_inventory_item_id = params[:order][:room_type_id];
        o.check_in_date = params[:order][:check_in_date]; 
        o.check_out_date = params[:order][:check_out_date];
        o.save       
=end

      end
      respond_with(@order) { |format| format.html { redirect_to checkout_path } }
    end
    
    
  end
end
