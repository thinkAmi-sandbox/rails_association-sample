class CreateFruits < ActiveRecord::Migration[7.0]
  def change
    create_table :fruits do |t|
      t.string :name
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
