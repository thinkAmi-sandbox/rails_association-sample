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
require "test_helper"

class ReservedProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
