# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plant_id   :integer
#
# Indexes
#
#  index_employees_on_plant_id  (plant_id)
#
# Foreign Keys
#
#  plant_id  (plant_id => plants.id)
#
require 'rails_helper'

RSpec.describe Employee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
