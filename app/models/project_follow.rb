class ProjectFollow < ActiveRecord::Base

  # === List of columns ===
  #   id          : integer 
  #   project_id  : integer 
  #   follower_id : integer 
  #   following   : boolean 
  #   created_at  : datetime 
  #   updated_at  : datetime 
  #   followed_at : datetime 
  # =======================

  belongs_to :project
  belongs_to :follower
end
