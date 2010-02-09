class AddFollowedAtToProjectFollows < ActiveRecord::Migration
  def self.up
    add_column :project_follows, :followed_at, :datetime
  end

  def self.down
    remove_column :project_follows, :followed_at
  end
end
