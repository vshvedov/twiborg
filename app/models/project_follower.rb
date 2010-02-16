class ProjectFollower < ActiveRecord::Base
  belongs_to :project
  belongs_to :follower
end

# == Schema Information
#
# Table name: project_followers
#
#  id          :integer(4)      not null, primary key
#  project_id  :integer(4)
#  follower_id :integer(4)
#  following   :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

