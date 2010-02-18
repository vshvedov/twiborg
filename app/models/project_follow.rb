class ProjectFollow < ActiveRecord::Base
  belongs_to :project
  belongs_to :follower

  def start_follow
    self.project.start_follow(follower.screen_name)
  end
end

# == Schema Information
#
# Table name: project_follows
#
#  id          :integer(4)      not null, primary key
#  project_id  :integer(4)
#  follower_id :integer(4)
#  following   :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#  followed_at :datetime
#

