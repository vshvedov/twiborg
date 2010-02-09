require 'digest/sha1'
class User < ActiveRecord::Base

  # === List of columns ===
  #   id                        : integer 
  #   name                      : string 
  #   twitter_uid               : string 
  #   avatar_url                : string 
  #   atoken                    : string 
  #   asecret                   : string 
  #   remember_token            : string 
  #   remember_token_expires_at : datetime 
  #   created_at                : datetime 
  #   updated_at                : datetime 
  # =======================

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :twitter_uid
  validates_uniqueness_of :twitter_uid
  validates_presence_of :atoken
  validates_presence_of :asecret

  has_many :projects, :dependent => :destroy

  def self.new_signature
    Digest::SHA1.hexdigest("token at time #{Time.now()}")
  end

  def forget_me
    self.remember_token = nil
    save(false)
  end

  def remember_me
    self.remember_token = self.class.new_signature
    save(false)
  end

  def refresh_token
    remember_me
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
