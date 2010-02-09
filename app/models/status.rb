class Status < ActiveRecord::Base

  # === List of columns ===
  #   id                : integer 
  #   keyword_id        : integer 
  #   twitter_id        : string 
  #   text              : string 
  #   source            : string 
  #   created_at        : datetime 
  #   updated_at        : datetime 
  #   profile_image_url : string 
  #   from_user         : string 
  #   from_user_id      : string 
  #   to_user_id        : string 
  # =======================

  validates_presence_of :keyword_id
  validates_presence_of :twitter_id
  validates_presence_of :text
  validates_uniqueness_of :twitter_id

  belongs_to :keyword
  has_one :project, :through => :keyword
  belongs_to :follower
end
