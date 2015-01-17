# == Schema Information
#
# Table name: game_session_questions
#
#  id                 :integer          not null, primary key
#  game_session_id    :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer          default("0")
#  opponent_time      :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class GameSessionQuestion < ActiveRecord::Base
  belongs_to :game_session
  belongs_to :question

  belongs_to :host_answer, class_name: 'Answer', foreign_key: :host_answer_id
  belongs_to :opponent_answer, class_name: 'Answer', foreign_key: :opponent_answer_id

  validates :game_session, presence: true
  validates :question, presence: true

  validates :host_time, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validates :opponent_time, numericality: { greater_than_or_equal_to: 0 }, on: :update

  # Generates offline session question
  def generate(session)
    if answer = online_answer
      update(opponent_answer: answer[0], opponent_time: answer[1],
        game_session: session)
    else
      update(opponent_answer: generate_answer,
        opponent_time: random_time,
        game_session: session)
    end
  end

  private

  # Generates random answer
  def generate_answer
    opponent_correct? ? question.correct_answer : question.random_incorrect_answer
  end

  # Generates correct answers with the probability of 0.7
  def opponent_correct?
    rand() <= 0.7 ? true : false
  end

  # Get random time in seconds
  def random_time
    (1..6).to_a.sample
  end

  # Get answer from already played sessions
  def online_answer
    # Find session questions with the same question
    sq = question.game_session_questions.sample
    # In offline sessions real players are hosts
    if sq && sq.host_answer && sq.host_time
      [sq.host_answer, sq.host_time]
    else
      false
    end
  end
end
