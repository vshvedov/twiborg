class Follower < ActiveRecord::Base

  # === List of columns ===
  #   id              : integer 
  #   name            : string 
  #   twitter_uid     : string 
  #   avatar_url      : string 
  #   followers_count : integer 
  #   friends_count   : integer 
  #   created_at      : datetime 
  #   updated_at      : datetime 
  # =======================

  has_many :project_follows
  has_many :project_followers

  def self.get_by_twitter_uid(client, uid)
    begin
      client.user(uid).cdump :user 
      self.find_by_twitter_uid(uid) || get(client.user(uid))
    rescue Twitter::NotFound
      return nil
    end
  end

  def self.get(profile)
    new_follower = self.find_by_twitter_uid(profile.id) || self.new
    
    new_follower.name = profile.screen_name unless profile.screen_name.blank?
    new_follower.twitter_uid = profile.id unless profile.id.blank?
    new_follower.avatar_url = profile.profile_image_url unless profile.profile_image_url.blank?
    new_follower.followers_count = profile.followers_count unless profile.followers_count.blank?
    new_follower.friends_count = profile.friends_count unless profile.friends_count.blank?

    new_follower.save
    new_follower
  end
end
