# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Parent < ApplicationRecord
  before_destroy -> { puts '[Parent] before destroy' }
  after_destroy -> { puts '[Parent] after destroy' }

  has_many :children
end