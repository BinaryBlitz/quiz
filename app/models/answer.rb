# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ApplicationRecord
  belongs_to :question

  has_many :game_questions, foreign_key: :host_answer_id, dependent: :destroy
  has_many :game_questions, foreign_key: :opponent_answer_id, dependent: :destroy

  validates :content, presence: true
end
