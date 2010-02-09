class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.references :user
      t.string :name
      t.string :twitter_uid
      t.string :avatar_url
      t.string :atoken, :null => false
      t.string :asecret, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
