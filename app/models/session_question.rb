# == Schema Information
#
# Table name: session_questions
#
#  id                 :integer          not null, primary key
#  session_id         :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer          default("0")
#  opponent_time      :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class SessionQuestion < ActiveRecord::Base
  belongs_to :session
  belongs_to :question

  belongs_to :host_answer, class_name: 'Answer', foreign_key: :host_answer_id
  belongs_to :opponent_answer, class_name: 'Answer', foreign_key: :opponent_answer_id

  validates :session, presence: true
  validates :question, presence: true

  validates :host_time, numericality: { greater_than_or_equal_to: 0 }
  validates :opponent_time, numericality: { greater_than_or_equal_to: 0 }
end
