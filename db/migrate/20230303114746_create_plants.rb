class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.references :maker, null: true, foreign_key: true

      t.timestamps
    end
  end
end
