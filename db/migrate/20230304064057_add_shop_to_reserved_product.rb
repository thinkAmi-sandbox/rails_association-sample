class AddShopToReservedProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :reserved_products, :shop, null: true, foreign_key: true
  end
end
