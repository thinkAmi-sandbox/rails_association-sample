class CreateSaleByCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_by_customers do |t|
      t.string :memo
      t.references :reserved_product, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
