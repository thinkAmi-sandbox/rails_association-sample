class AddCountryToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :country, null: true, foreign_key: true
  end
end
