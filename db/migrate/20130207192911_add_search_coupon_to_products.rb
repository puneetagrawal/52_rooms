class AddSearchCouponToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :search_coupon, :string
  end
end
