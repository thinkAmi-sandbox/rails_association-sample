# == Schema Information
#
# Table name: makers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_makers_on_country_id  (country_id)
#
# Foreign Keys
#
#  country_id  (country_id => countries.id)
#
class Maker < ApplicationRecord
  belongs_to :country, optional: true
  has_many :plants
  has_many :reserved_products
end
