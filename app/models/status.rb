class Status < ActiveRecord::Base

  validates_presence_of :keyword_id
  validates_presence_of :twitter_id
  validates_presence_of :text
  validates_uniqueness_of :twitter_id

  belongs_to :keyword
  has_one :project, :through => :keyword
  belongs_to :follower

  after_create :parse_and_retweet, :start_follow

  def parse_and_retweet
    if self.can_retweet?
      retweet = Retweet.new(:text => self.text, :from_user => self.from_user, :from_user_id => self.from_user_id)
      retweet.errors.each{ |e, m| puts "ERRORS", "#{e} #{m}" } unless (self.project.retweets << retweet)
    end
  end

  def can_retweet?
    !(self.text =~ /.*(http\:\/\/[^\s\n]+).*/).nil? && (self.text + self.from_user + 'RT @: ').length < 140 && (self.project.retweets.blank? || self.project.retweets.last.created_at < Time.now - self.project.retweet_interval - rand(self.project.retweet_interval_delta))
  end

  def start_follow
    if self.can_follow?
      profile = self.project.profile(from_user)
      follower = Follower.find_by_screen_name(from_user) || Follower.create(profile)
      unless follower.nil? || profile.nil?
        new_follow = ProjectFollow.new(:follower_id => follower.id, :following => profile.following)
        self.project.project_follows << new_follow
        new_follow.start_follow
      end
    end
  end

  def can_follow?
    self.project.follows.find_by_screen_name(from_user).nil? && (self.project.project_follows.blank? || self.project.project_follows.count(:conditions => ['created_at > ?', Time.now - self.project.follow_interval]) < self.project.follows_in_interval && self.project.project_follows.last.created_at < Time.now - self.project.next_follow_interval) && self.project.name != from_user
  end
end

# == Schema Information
#
# Table name: statuses
#
#  id                :integer(4)      not null, primary key
#  keyword_id        :integer(4)
#  twitter_id        :string(255)
#  text              :string(255)
#  source            :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  profile_image_url :string(255)
#  from_user         :string(255)
#  from_user_id      :string(255)
#  to_user_id        :string(255)
#

