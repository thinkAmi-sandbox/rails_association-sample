class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.references :user_group, null: true, foreign_key: true

      t.timestamps
    end
  end
end
