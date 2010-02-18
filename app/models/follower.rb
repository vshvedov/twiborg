class Follower < ActiveRecord::Base
  has_many :project_follows
  has_many :project_followers

  before_validation :change_id

  attr_writer :profile_sidebar_border_color, :profile_background_tile, :name, :profile_sidebar_fill_color, :location, :profile_link_color, :favourites_count, :contributors_enabled, :url, :utc_offset, :profile_text_color, :lang, :protected, :description, :geo_enabled, :notifications, :verified, :profile_background_color, :time_zone, :statuses_count, :profile_background_image_url, :following, :status

  def after_initialize
    nil
  end

  def change_id
    if twitter_uid.blank?
      self.twitter_uid = self.id
      self.id = nil
    end
  end
end


# == Schema Information
#
# Table name: followers
#
#  id                :integer(4)      not null, primary key
#  screen_name       :string(255)
#  twitter_uid       :string(255)
#  profile_image_url :string(255)
#  followers_count   :integer(4)
#  friends_count     :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#

