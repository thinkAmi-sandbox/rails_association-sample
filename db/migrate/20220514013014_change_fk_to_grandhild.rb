class ChangeFkToGrandhild < ActiveRecord::Migration[7.0]
  def change
    # 既存のFKを削除
    remove_foreign_key :grandchildren, :children

    # FKを追加
    add_foreign_key :grandchildren, :children, on_delete: :cascade
  end
end
