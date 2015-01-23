# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default("false"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :game_session_questions, foreign_key: :host_answer_id, dependent: :destroy
  has_many :game_session_questions, foreign_key: :opponent_answer_id, dependent: :destroy

  validates :content, presence: true
  validates :question, presence: true
end
