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

  scope :desc, -> { order(created_at: :desc) }
  scope :players, -> { includes(:player).where.not(player: nil).desc }
  scope :questions, -> { includes(:question).where.not(question: nil).desc }
  scope :feedback, -> { where(player: nil, question: nil).desc }
end
