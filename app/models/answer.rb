# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :session_questions, foreign_key: :host_answer_id, dependent: :destroy
  has_many :session_questions, foreign_key: :opponent_answer_id, dependent: :destroy

  validates :content, presence: true
end
