# == Schema Information
#
# Table name: facts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fact < ActiveRecord::Base
  validates :content, presence: true

  def self.random
    order('RANDOM()').first.try(:content)
  end
end
