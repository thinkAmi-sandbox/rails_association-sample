class AddFruitToCultivars < ActiveRecord::Migration[7.0]
  def change
    add_reference :cultivars, :fruit, null: false, foreign_key: true
  end
end
