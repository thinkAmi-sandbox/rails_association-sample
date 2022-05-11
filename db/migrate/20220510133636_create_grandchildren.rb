class CreateGrandchildren < ActiveRecord::Migration[7.0]
  def change
    create_table :grandchildren do |t|
      t.string :name
      t.references :child, null: false, foreign_key: true

      t.timestamps
    end
  end
end
