# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  message     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#

class Report < ActiveRecord::Base
  belongs_to :player
  belongs_to :question

  validates :message, presence: true
end
