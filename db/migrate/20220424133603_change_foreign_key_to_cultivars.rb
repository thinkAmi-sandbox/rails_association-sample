class ChangeForeignKeyToCultivars < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cultivars, :fruit_id, true
  end
end
