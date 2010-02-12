class AddLastSearchAtColumnToKeywords < ActiveRecord::Migration
  def self.up
    add_column :keywords, :last_search_at, :datetime
  end

  def self.down
    remove_column :keywords, :last_search_at
  end
end
