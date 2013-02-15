class AddColumnToSpreeAddresses < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :email, :string
    add_column :spree_addresses, :customer_name, :string
    add_column :spree_addresses, :mobile_cc, :string
    add_column :spree_addresses, :mobile_num, :string
    add_column :spree_addresses, :phone_cc, :string
    add_column :spree_addresses, :phone_std, :string
  end
end
