Spree::Order.class_eval do
  
  attr_accessible :booking_date, :check_in_date, :check_out_date, :f2r_hotel_inventory_item_id,
   :product_id, :quantity, :email, :line_items 
  belongs_to :spree_line_item
  #validates :email, :presence => false, :if => :require_email
  #validates :email, :allow_blank => true
  #accepts_nested_attributes_for :spree_line_item

  checkout_flow do
    go_to_state :address, :if => lambda { |order| order.payment_required? }
    go_to_state :payment, :if => lambda { |order| order.payment_required? }
    go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
    go_to_state :complete
    remove_transition :from => :delivery, :to => :confirm
  end

  state_machine do
    after_transition :from => :cart, :to => :address do |order|
      order.next
    end
  end


   def add_variant(variant, quantity = 1, check_in=00-00-0000, check_out_date=00-00-0000, product_id=1, f2r_hotel_inventory_item_id=1, currency = nil)
       current_item = find_line_item_by_variant(variant)
       if current_item
         current_item.quantity += quantity
         current_item.check_in_date = check_in
         current_item.check_out_date = check_out_date
         current_item.product_id = product_id
         current_item.f2r_hotel_inventory_item_id = f2r_hotel_inventory_item_id
         current_item.currency = currency unless currency.nil?
         current_item.save
       else
         #current_item = Spree::LineItem.new(:quantity => quantity)
         current_item = Spree::LineItem.new(:quantity => quantity, :check_in_date=>check_in, :check_out_date => check_out_date, :product_id => product_id, :f2r_hotel_inventory_item_id => f2r_hotel_inventory_item_id)
         current_item.variant = variant
         if currency
           current_item.currency = currency unless currency.nil?
           current_item.price    = variant.price_in(currency).amount
         else
           current_item.price    = variant.price
         end

         self.line_items << current_item

       end
       self.reload
       current_item
     end

     
=begin
  def add_details(product_id)


  end
=end

end



