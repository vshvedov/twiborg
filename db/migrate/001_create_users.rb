class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :twitter_uid
      t.string :avatar_url
      t.string :atoken, :null => false
      t.string :asecret, :null => false
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.timestamps
    end
    add_index :users, :atoken
  end

  def self.down
    drop_table :users
  end
end
