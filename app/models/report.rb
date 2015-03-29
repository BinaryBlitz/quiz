# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Report < ActiveRecord::Base
  belongs_to :player

  validates :player, presence: true
  validates :message, presence: true
end
