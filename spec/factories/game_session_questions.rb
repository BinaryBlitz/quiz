# == Schema Information
#
# Table name: game_session_questions
#
#  id                 :integer          not null, primary key
#  game_session_id    :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer
#  opponent_time      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :game_session_question do
    game_session
    question
    association :host_answer, factory: :host_answer
    association :opponent_answer, factory: :opponent_answer
    host_time 2
    opponent_time 4
  end
end
