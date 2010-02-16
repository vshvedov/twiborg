class Retweet < ActiveRecord::Base
  validates_presence_of :link
  validates_uniqueness_of :link, :scope => :project_id
  validates_presence_of :project_id
  validates_presence_of :text
  validates_presence_of :from_user
  validates_presence_of :from_user_id

  belongs_to :project

  def before_validation
    self.link = self.text.gsub /.*(http\:\/\/[^\s\n]+).*/, '\1'
  end

  def after_create
    self.project.send_tweet("RT @#{from_user}: #{text}")
    puts 'RETWEET', "\tRT @#{from_user}: #{text}"
  end
end


# == Schema Information
#
# Table name: retweets
#
#  id           :integer(4)      not null, primary key
#  link         :string(255)
#  text         :string(255)
#  from_user    :string(255)
#  from_user_id :string(255)
#  project_id   :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#

