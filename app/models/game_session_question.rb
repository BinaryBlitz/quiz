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

class GameSessionQuestion < ActiveRecord::Base
  belongs_to :game_session
  belongs_to :question

  belongs_to :host_answer, class_name: 'Answer', foreign_key: :host_answer_id
  belongs_to :opponent_answer,
             class_name: 'Answer', foreign_key: :opponent_answer_id

  validates :game_session, presence: true
  validates :question, presence: true

  validates :host_time,
            numericality: { greater_than_or_equal_to: 0 },
            on: :update, allow_blank: true
  validates :opponent_time,
            numericality: { greater_than_or_equal_to: 0 },
            on: :update, allow_blank: true
  validate :valid_host_answer, on: :update
  validate :valid_opponent_answer, on: :update

  CORRECT_ANSWER_PROBABILITY = 0.5

  def host_points
    return 0 unless host_time
    if game_session.game_session_questions.last == self
      (20 - host_time) * 2
    else
      20 - host_time
    end
  end

  def opponent_points
    return 0 unless opponent_time
    if game_session.game_session_questions.last == self
      (20 - opponent_time) * 2
    else
      20 - opponent_time
    end
  end

  def player_answer_correct?(player)
    if player == game_session.host
      host_answer && host_answer.correct?
    elsif player == game_session.opponent
      opponent_answer && opponent_answer.correct?
    end
  end

  def player_time(player)
    if player == game_session.host
      host_time
    elsif player == game_session.opponent
      opponent_time
    end
  end

  # Generates offline session question
  def generate_for_offline
    opponent_answer, opponent_time = load_or_generate_answer
    update(opponent_answer: opponent_answer, opponent_time: opponent_time)
  end

  private

  # Find online answer, generate if not found
  def load_or_generate_answer
    if online_answers?
      online_answer
    else
      [generate_answer, random_time]
    end
  end

  def online_answers?
    # Find session questions with the same question
    # TODO: Loop through many session questions
    @random_question = question.game_session_questions.sample
    @random_question && @random_question.host_answer && @random_question.host_time
  end

  # Get answer from already played sessions
  def online_answer
    # In offline sessions real players are hosts
    [@random_question.host_answer, @random_question.host_time]
  end

  def generate_answer
    opponent_correct? ? question.correct_answer : question.random_incorrect_answer
  end

  def random_time
    rand(6) + 1
  end

  # Generates correct answers with the probability of 0.7
  def opponent_correct?
    rand <= CORRECT_ANSWER_PROBABILITY
  end

  def valid_host_answer
    return if !question || !host_answer
    unless question.answers.include?(host_answer)
      errors.add(:host_answer, "doesn't belong to the question")
    end
  end

  def valid_opponent_answer
    return if !question || !opponent_answer
    unless question.answers.include?(opponent_answer)
      errors.add(:opponent_answer, "doesn't belong to the question")
    end
  end
end
