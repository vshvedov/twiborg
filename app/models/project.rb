class Project < ActiveRecord::Base

  # === List of columns ===
  #   id          : integer 
  #   user_id     : integer 
  #   name        : string 
  #   twitter_uid : string 
  #   avatar_url  : string 
  #   atoken      : string 
  #   asecret     : string 
  #   created_at  : datetime 
  #   updated_at  : datetime 
  # =======================

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :twitter_uid
  validates_presence_of :atoken
  validates_presence_of :asecret

  belongs_to :user
  has_many :project_follows, :dependent => :destroy
  has_many :project_followers, :dependent => :destroy
  has_many :follows, :through => :project_follows, :source => :follower
  has_many :followers, :through => :project_followers
  has_many :keywords

  after_create :refresh_followers, :refresh_follows

  def refresh_followers
    self.client.followers.each do |f|
      if self.followers.count(:conditions => {:twitter_uid => f.id}) == 0
        new_follower = Follower.get(f)
        self.project_followers << ProjectFollower.new(:follower_id => new_follower.id, :following => f.following)
      end
    end
  end

  def refresh_follows
    self.client.friends.each do |f|
      if self.follows.count(:conditions => {:twitter_uid => f.id}) == 0
        new_follow = Follower.get(f)
        self.project_follows << ProjectFollow.new(:follower_id => new_follow.id, :following => self.client.friend_ids(:id => f.id).include?(twitter_uid))
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

  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twitter::Base.new(oauth)
    end
  end
end
