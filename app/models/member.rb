# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_group_id :integer
#
# Indexes
#
#  index_members_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  user_group_id  (user_group_id => user_groups.id)
#
class Member < ApplicationRecord
  belongs_to :user_group, required: false
end
