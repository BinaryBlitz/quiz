# == Schema Information
#
# Table name: session_questions
#
#  id              :integer          not null, primary key
#  session_id      :integer
#  question_id     :integer
#  player_points   :integer          default("0")
#  opponent_points :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SessionQuestion < ActiveRecord::Base
  belongs_to :session
  belongs_to :question

  has_one :host_answer
  has_one :opponent_answer

  validates :session, presence: true, on: :create
  validates :question, presence: true, on: :create

  validates :host_time, numericality: { greater_than_or_equal_to: 0 }
  validates :opponent_time, numericality: { greater_than_or_equal_to: 0 }
end
