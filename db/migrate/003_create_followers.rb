class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.string :name
      t.string :twitter_uid
      t.string :avatar_url
      t.integer :followers_count
      t.integer :friends_count

      t.timestamps
    end
  end

  def self.down
    drop_table :followers
  end
end
