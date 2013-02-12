class AddColumnsToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :check_in_date, :date
    add_column :spree_line_items, :check_out_date, :date
    add_column :spree_line_items, :product_id, :integer
    add_column :spree_line_items, :f2r_hotel_inventory_item_id, :integer
  end
end
