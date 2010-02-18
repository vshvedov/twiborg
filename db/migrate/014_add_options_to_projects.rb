class AddOptionsToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :follows_in_interval, :integer, :default => 5
    add_column :projects, :follow_interval, :integer, :default => 1200
    add_column :projects, :next_follow_interval, :integer, :default => 120
    add_column :projects, :retweet_interval, :integer, :default => 120
    add_column :projects, :retweet_interval_delta, :integer, :default => 300
  end

  def self.down
    remove_column :projects, :follows_in_interval
    remove_column :projects, :follow_interval
    remove_column :projects, :next_follow_interval
    remove_column :projects, :retweet_interval
    remove_column :projects, :retweet_interval_delta
  end
end
