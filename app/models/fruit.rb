# == Schema Information
#
# Table name: fruits
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  food_id    :integer          not null
#
# Indexes
#
#  index_fruits_on_food_id  (food_id)
#
# Foreign Keys
#
#  food_id  (food_id => foods.id)
#
class Fruit < ApplicationRecord
  belongs_to :food
  has_many :cultivars
  has_many :full_cultivars, -> { where('cultivars.name LIKE "シナノ%"') }, class_name: 'Cultivar'
end
