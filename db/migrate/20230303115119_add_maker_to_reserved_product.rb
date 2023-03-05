class AddMakerToReservedProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :reserved_products, :maker, null: true, foreign_key: true
  end
end
