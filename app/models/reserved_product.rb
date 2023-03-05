# == Schema Information
#
# Table name: reserved_products
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  maker_id   :integer
#  shop_id    :integer
#
# Indexes
#
#  index_reserved_products_on_maker_id  (maker_id)
#  index_reserved_products_on_shop_id   (shop_id)
#
# Foreign Keys
#
#  maker_id  (maker_id => makers.id)
#  shop_id   (shop_id => shops.id)
#
class ReservedProduct < ApplicationRecord
  has_many :sales
  has_many :sale_by_customers
  belongs_to :maker, optional: true
  belongs_to :shop, optional: true

  scope :no_reservations_by, ->(customer_id) {
    sql = ApplicationRecord.sanitize_sql_array(
      ['LEFT OUTER JOIN sale_by_customers
            ON (reserved_products.id = sale_by_customers.reserved_product_id AND
                sale_by_customers.customer_id = :customer_id)',
       { customer_id: customer_id }])

    joins(sql).where(sale_by_customers: { id: nil })
  }
end
