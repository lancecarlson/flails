# == Schema Information
# Schema version: 20090218105738
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  subject    :string(255)
#  body       :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates_presence_of :subject, :body

  def id=(id)
    write_attribute(:id, id);
  end
end
