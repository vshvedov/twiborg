class AddSynchronizedAtColumnToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :synchronized_at, :datetime
  end

  def self.down
    remove_column :projects, :synchronized_at
  end
end
