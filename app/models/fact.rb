# == Schema Information
#
# Table name: facts
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Fact < ActiveRecord::Base
  validates :content, presence: true

  scope :random, -> { order('RANDOM()') }
end
