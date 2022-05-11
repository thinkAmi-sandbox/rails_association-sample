# == Schema Information
#
# Table name: children
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer          not null
#
# Indexes
#
#  index_children_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  parent_id  (parent_id => parents.id)
#
class Child < ApplicationRecord
  belongs_to :parent
  has_many :grandchildren
end
