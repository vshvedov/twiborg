class Keyword < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   query      : string 
  #   project_id : integer 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  validates_presence_of :query
  validates_presence_of :project_id

  belongs_to :project
  has_many :statuses

  after_create :search

  def search
    Twitter::Search.new(query).fetch().results.each do |res|
      res.cdump :tweet
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
end
