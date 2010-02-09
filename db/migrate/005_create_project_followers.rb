class CreateProjectFollowers < ActiveRecord::Migration
  def self.up
    create_table :project_followers do |t|
      t.references :project
      t.references :follower
      t.boolean :following

      t.timestamps
    end
  end

  def self.down
    drop_table :project_followers
  end
end
