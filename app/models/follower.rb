class Follower < ActiveRecord::Base
  has_many :project_follows
  has_many :project_followers

  def self.get_by_twitter_uid(project, screen_name)
    begin
      self.find_by_name(screen_name) || get(project.profile(screen_name))
    rescue Twitter::NotFound
      puts "ERROR\nCan't found user"
      return nil
    end
  end

  def self.get(profile)
    new_follower = self.find_by_name(profile.screen_name) || self.new
    
    new_follower.name = profile.screen_name unless profile.screen_name.blank?
    new_follower.twitter_uid = profile.id unless profile.id.blank?
    new_follower.avatar_url = profile.profile_image_url unless profile.profile_image_url.blank?
    new_follower.followers_count = profile.followers_count unless profile.followers_count.blank?
    new_follower.friends_count = profile.friends_count unless profile.friends_count.blank?

    new_follower.errors.each{|e| puts("ERRORS\n"+e.join(" "))} unless new_follower.save
    new_follower
  end
end

# == Schema Information
#
# Table name: followers
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  twitter_uid     :string(255)
#  avatar_url      :string(255)
#  followers_count :integer(4)
#  friends_count   :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

