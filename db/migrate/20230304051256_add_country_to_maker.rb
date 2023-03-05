class AddCountryToMaker < ActiveRecord::Migration[7.0]
  def change
    add_reference :makers, :country, null: true, foreign_key: true
  end
end
