class Project < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :twitter_uid
  validates_presence_of :atoken
  validates_presence_of :asecret
  validates_presence_of :follows_in_interval
  validates_presence_of :follow_interval
  validates_presence_of :next_follow_interval
  validates_presence_of :retweet_interval
  validates_presence_of :retweet_interval_delta

  belongs_to :user
  has_many :project_follows, :dependent => :destroy
  has_many :project_followers, :dependent => :destroy
  has_many :follows, :through => :project_follows, :source => :follower
  has_many :followers, :through => :project_followers
  has_many :keywords
  has_many :retweets
  has_many :ivents

  after_create :refresh_followers, :refresh_follows

  def refresh_followers
    client.followers.each do |f|
      if self.followers.count(:conditions => {:twitter_uid => f.id}) == 0
        new_follower = Follower.get(f)
        self.project_followers << ProjectFollower.new(:follower_id => new_follower.id, :following => f.following)
      end
    end
  end

  def refresh_follows
    client.friends.each do |f|
      if self.follows.count(:conditions => {:twitter_uid => f.id}) == 0
        new_follow = Follower.get(f)
        self.project_follows << ProjectFollow.new(:follower_id => new_follow.id, :following => client.friend_ids(:id => f.id).include?(twitter_uid))
      end
    end
  end

  def follower?(name)
    followers.count(:conditions => {:name => name}) != 0
  end

  def follow?(name)
    follows.count(:conditions => {:name => name}) != 0
  end

  def oauth
    @oauth ||= Twitter::OAuth.new(APP_CONFIG[:consumer_key], APP_CONFIG[:consumer_secret], :sign_in => true)
  end

  def count_ivents from_date, to_date, type
    self.ivents.count(
    :conditions => ['created_at <= :date_to AND created_at >= :date_from AND ivent_type_id = :type', {
      :date_from => from_date, 
      :date_to => to_date, 
      :type => IventType.get(type).id}])
  end

  # Twitter methods
  def is_follower? screen_name
    begin
      client.friendship_exists?(screen_name, name)
    rescue Twitter::RateLimitExceeded
      self.ivents << Ivent.put(id, 'limit')
      nil
    end
  end

  def is_friend? screen_name
    begin
      client.friendship_exists?(name, screen_name)
    rescue Twitter::RateLimitExceeded
      self.ivents << Ivent.put(id, 'limit')
      nil
    end
  end

  def profile screen_name
    begin
      client.user(screen_name)
    rescue Twitter::RateLimitExceeded
      self.ivents << Ivent.put(id, 'limit')
      nil
    end
  end

  def start_follow screen_name
    begin
      unless is_friend? screen_name
        client.friendship_create(screen_name, true)
        self.ivents << Ivent.put(id, 'follow')
      end
    rescue Twitter::RateLimitExceeded
      self.ivents << Ivent.put(id, 'limit')
      nil
    end
  end

  def send_tweet text
    begin
      client.update(text)
      self.ivents << Ivent.put(id, 'retweet')
    rescue Twitter::RateLimitExceeded
      self.ivents << Ivent.put(id, 'limit')
      nil
    end
  end

private

  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twi.new(oauth)
    end
  end
end


# == Schema Information
#
# Table name: projects
#
#  id                     :integer(4)      not null, primary key
#  user_id                :integer(4)
#  name                   :string(255)
#  twitter_uid            :string(255)
#  avatar_url             :string(255)
#  atoken                 :string(255)     not null
#  asecret                :string(255)     not null
#  created_at             :datetime
#  updated_at             :datetime
#  follows_in_interval    :integer(4)      default(5)
#  follow_interval        :integer(4)      default(1200)
#  next_follow_interval   :integer(4)      default(120)
#  retweet_interval       :integer(4)      default(120)
#  retweet_interval_delta :integer(4)      default(300)
#

