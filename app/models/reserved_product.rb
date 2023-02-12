# == Schema Information
#
# Table name: reserved_products
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ReservedProduct < ApplicationRecord
  has_many :sales
  has_many :sale_by_customers

  scope :no_reservations_by, ->(customer_id) {
    sql = ApplicationRecord.sanitize_sql_array(
      ['LEFT OUTER JOIN sale_by_customers
            ON (reserved_products.id = sale_by_customers.reserved_product_id AND
                sale_by_customers.customer_id = :customer_id)',
       { customer_id: customer_id }])

    joins(sql).where(sale_by_customers: { id: nil })
  }
end
