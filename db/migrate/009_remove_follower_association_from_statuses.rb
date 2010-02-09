class RemoveFollowerAssociationFromStatuses < ActiveRecord::Migration
  def self.up
    remove_column :statuses, :follower_id
    add_column :statuses, :profile_image_url, :string
    add_column :statuses, :from_user, :string
    add_column :statuses, :from_user_id, :string
    add_column :statuses, :to_user_id, :string
  end

  def self.down
    add_column :statuses, :follower_id, :integer
    remove_column :statuses, :profile_image_url
    remove_column :statuses, :from_user
    remove_column :statuses, :from_user_id
    remove_column :statuses, :to_user_id
  end
end
