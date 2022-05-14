class ChangeFkToChild < ActiveRecord::Migration[7.0]
  def change
    # 既存のFKを削除
    remove_foreign_key :children, :parents

    # FKを追加
    add_foreign_key :children, :parents, on_delete: :cascade
  end
end
