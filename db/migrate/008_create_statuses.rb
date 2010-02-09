class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.references :keyword
      t.references :follower
      t.string :twitter_id
      t.string :text
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
