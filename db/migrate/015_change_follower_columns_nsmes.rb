class ChangeFollowerColumnsNsmes < ActiveRecord::Migration
  def self.up
    rename_column :followers, :name, :screen_name
    rename_column :followers, :avatar_url, :profile_image_url
  end

  def self.down
    rename_column :followers, :screen_name, :name
    rename_column :followers, :profile_image_url, :avatar_url
  end
end
