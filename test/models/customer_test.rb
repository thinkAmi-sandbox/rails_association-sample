# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_customers_on_country_id  (country_id)
#
# Foreign Keys
#
#  country_id  (country_id => countries.id)
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
