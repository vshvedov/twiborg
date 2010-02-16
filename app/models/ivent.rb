class Ivent < ActiveRecord::Base
  belongs_to :ivent_type
  belongs_to :project

  validates_presence_of :ivent_type_id
  validates_presence_of :project_id

  def self.put project_id, ivent_type_name
    create(:project_id => project_id, :ivent_type_id => IventType.get(ivent_type_name).id)
  end
end


# == Schema Information
#
# Table name: ivents
#
#  id            :integer(4)      not null, primary key
#  ivent_type_id :integer(4)
#  project_id    :integer(4)
#  data          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

