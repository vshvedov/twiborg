class CreateRetweets < ActiveRecord::Migration
  def self.up
    create_table :retweets do |t|
      t.string :link
      t.string :text
      t.string :from_user
      t.string :from_user_id
      t.references :project
      t.timestamps
    end
  end

  def self.down
    drop_table :retweets
  end
end
