class IventType < ActiveRecord::Base

  def self.get name
    find_by_name name
  end

end

# == Schema Information
#
# Table name: ivent_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

