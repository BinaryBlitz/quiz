# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#

class GameSession < ActiveRecord::Base
  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  belongs_to :topic

  has_many :game_session_questions, dependent: :destroy
  has_many :questions, through: :game_session_questions

  validates :host, presence: true
  validates :topic, presence: true

  MAX_ITERATIONS = 10

  def generate
    # Offline only for now
    self.offline = true

    6.times do
      # Avoid repetitions
      sq = nil
      iteration = 0
      loop do
        iteration += 1
        sq = GameSessionQuestion.new(question: Question.where(topic: topic).sample)
        break unless questions.include?(sq.question) || iteration <= MAX_ITERATIONS
      end

      # Stop if there're no questions left
      break if sq.nil?

      # Random answer and time
      sq.generate_for_offline(self) if offline
      self.game_session_questions << sq
    end
  end
end
