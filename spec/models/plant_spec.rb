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
require 'rails_helper'

RSpec.describe Plant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
