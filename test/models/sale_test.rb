# == Schema Information
#
# Table name: sales
#
#  id                  :integer          not null, primary key
#  memo                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  reserved_product_id :integer          not null
#
# Indexes
#
#  index_sales_on_reserved_product_id  (reserved_product_id)
#
# Foreign Keys
#
#  reserved_product_id  (reserved_product_id => reserved_products.id)
#
require "test_helper"

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
