# == Schema Information
#
# Table name: plants
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  maker_id   :integer
#
# Indexes
#
#  index_plants_on_maker_id  (maker_id)
#
# Foreign Keys
#
#  maker_id  (maker_id => makers.id)
#
class Plant < ApplicationRecord
  belongs_to :maker
  has_many :employees
end
