# == Schema Information
#
# Table name: cultivars
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fruit_id   :integer          not null
#
# Indexes
#
#  index_cultivars_on_fruit_id  (fruit_id)
#
# Foreign Keys
#
#  fruit_id  (fruit_id => fruits.id)
#
class Cultivar < ApplicationRecord
  belongs_to :fruit
end
