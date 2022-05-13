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
  before_destroy -> { puts '[Child] before destroy' }
  after_destroy -> { puts '[Child] after destroy' }

  belongs_to :parent
  has_many :grandchildren, dependent: :delete_all
end