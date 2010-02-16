class CreateIvents < ActiveRecord::Migration
  def self.up
    create_table :ivents do |t|
      t.references :ivent_type
      t.references :project
      t.string :data
      t.timestamps
    end
  end

  def self.down
    drop_table :ivents
  end
end
