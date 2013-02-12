class AddCouponDescriptionToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :coupon_description, :text
  end
end
