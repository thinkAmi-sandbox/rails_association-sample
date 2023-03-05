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
class Customer < ApplicationRecord
  belongs_to :country
end
