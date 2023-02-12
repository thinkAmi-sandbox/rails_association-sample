# == Schema Information
#
# Table name: sale_by_customers
#
#  id                  :integer          not null, primary key
#  memo                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_id         :integer          not null
#  reserved_product_id :integer          not null
#
# Indexes
#
#  index_sale_by_customers_on_customer_id          (customer_id)
#  index_sale_by_customers_on_reserved_product_id  (reserved_product_id)
#
# Foreign Keys
#
#  customer_id          (customer_id => customers.id)
#  reserved_product_id  (reserved_product_id => reserved_products.id)
#
class SaleByCustomer < ApplicationRecord
  belongs_to :reserved_product
  belongs_to :customer

  # has_many :non, ->(customer_id) { where("customers.id = #{customer_id}") }, class_name: 'Customer'
end
