class AddHomePageVisibilityToSpreeProducts  < ActiveRecord::Migration
  def change
    add_column :spree_products, :home_page_visibility, :boolean,:default=>true
    add_column :spree_products, :coupon_text, :string
  end
end
