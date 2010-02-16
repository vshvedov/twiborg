class CreateIventTypes < ActiveRecord::Migration
  def self.up
    create_table :ivent_types do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :ivent_types
  end
end
