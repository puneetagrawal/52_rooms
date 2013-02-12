class AddRoomDescToF2rHotelInventoryItem < ActiveRecord::Migration
  def change
    add_column :f2r_hotel_inventory_items, :room_desc, :text
    add_column :f2r_hotel_inventory_items, :sub_heading, :string
  end
end
