class CreateReservedProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :reserved_products do |t|
      t.string :name

      t.timestamps
    end
  end
end
