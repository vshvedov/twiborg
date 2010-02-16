require 'digest/sha1'
class User < ActiveRecord::Base
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
      Twi.new(oauth)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  name                      :string(255)
#  twitter_uid               :string(255)
#  avatar_url                :string(255)
#  atoken                    :string(255)     not null
#  asecret                   :string(255)     not null
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

