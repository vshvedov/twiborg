class Keyword < ActiveRecord::Base
  validates_presence_of :query
  validates_presence_of :project_id

  belongs_to :project
  has_many :statuses, :dependent => :destroy

  # after_create :search

  KEYWORD_SEARCH_INTRRVAL = 30

  def search
    if self.statuses.blank?
      new_tweets = Twitter::Search.new(query).fetch().results
    else
      new_tweets = Twitter::Search.new(query).since(Status.maximum(:twitter_id)).fetch().results
    end
    puts "\n\nproject: @#{self.project.name} \t:keyword: #{query} \t#{new_tweets.size} new tweets from:"
    new_tweets.each do |res|
      puts "\t\t@#{res.from_user}"
      unless res.nil?
        self.statuses << (Status.find_by_twitter_id(res.id) || Status.new({
          :profile_image_url => res.profile_image_url,
          :from_user => res.from_user,
          :from_user_id => res.from_user_id,
          :to_user_id => res.to_user_id,
          :text => res.text,
          :source => res.source,
          :twitter_id => res.id
        }))
      end
    end
    self.update_attribute :last_search_at, Time.now.utc
  end

  def self.periodic_search
    self.all(:conditions => ['last_search_at IS NULL OR last_search_at < ?', Time.now.utc - KEYWORD_SEARCH_INTRRVAL]).each{|k|k.search}
  end
end

# == Schema Information
#
# Table name: keywords
#
#  id             :integer(4)      not null, primary key
#  query          :string(255)
#  project_id     :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  last_search_at :datetime
#

