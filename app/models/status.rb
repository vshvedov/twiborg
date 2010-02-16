class Status < ActiveRecord::Base
  FOLLOWS_IN_INTERVAL = 5 # Amount of new follows per follow interval
  FOLLOW_INTERVAL = 1200 # Interval for new follows
  NEXT_FOLLOW_INTERVAL = 20 # Interval between two successive follows
  RETWEET_INTERVAL = 60 # Interval before retweet next status
  RETWEET_INTERVAL_DELTA = 300 # Delta to random increate retweet interval

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
    !(self.text =~ /.*(http\:\/\/[^\s\n]+).*/).nil? && (self.text + self.from_user + 'RT @: ').length < 140 && (self.project.retweets.blank? || self.project.retweets.last.created_at < Time.now - RETWEET_INTERVAL - rand(RETWEET_INTERVAL_DELTA))
  end

  def start_follow
    if self.can_follow?
      follower = Follower.find_by_name(self.from_user) || Follower.get_by_twitter_uid(self.project, self.from_user)
      self.project.project_follows << ProjectFollow.new(:follower_id => follower.id, :following => (self.project.is_follower?(follower.name))) unless follower.nil?
    end
  end

  def can_follow?
    self.project.follows.find_by_name(from_user).nil? && (self.project.project_follows.blank? || self.project.project_follows.count(:conditions => ['created_at > ?', Time.now - FOLLOW_INTERVAL]) < FOLLOWS_IN_INTERVAL && self.project.project_follows.last.created_at < Time.now - NEXT_FOLLOW_INTERVAL) && self.project.name != from_user
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

