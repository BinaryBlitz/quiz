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
  after_create :generate

  # Associations
  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  belongs_to :topic

  has_many :game_session_questions, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :questions, through: :game_session_questions
  has_many :lobbies, dependent: :destroy

  # Validations
  validates :host, presence: true
  validates :topic, presence: true

  # Scopes
  scope :last_week, -> { where(updated_at: (1.week.ago)..(Time.zone.now)) }

  def player_points(player)
    if player == host
      host_points
    elsif player == opponent
      opponent_points
    else
      0
    end
  end

  def host_points
    sum = 0
    game_session_questions.each do |question|
      sum += question.host_points
    end
    sum
  end

  def opponent_points
    sum = 0
    game_session_questions.each do |question|
      sum += question.opponent_points
    end
    sum
  end

  def last_question?(session_question)
    game_session_questions.last == session_question
  end

  private

  def generate
    questions = Question.where(topic: topic).sample(6)
    questions.map! { |q| game_session_questions.create(question: q) }
    game_session_questions.each(&:generate_for_offline) if offline
  end
end
