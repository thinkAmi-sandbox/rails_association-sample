# == Schema Information
#
# Table name: grandchildren
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  child_id   :integer          not null
#
# Indexes
#
#  index_grandchildren_on_child_id  (child_id)
#
# Foreign Keys
#
#  child_id  (child_id => children.id)
#
class Grandchild < ApplicationRecord
  belongs_to :child
end
