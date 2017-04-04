# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#  closed      :boolean
#  finisher_id :integer
#

class GameSession < ApplicationRecord
  after_create :generate_session

  # Associations
  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  belongs_to :finisher, class_name: 'Player', foreign_key: 'finisher_id'
  belongs_to :topic

  has_many :game_questions, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :questions, through: :game_questions
  has_many :lobbies, dependent: :destroy

  # Validations
  validates :topic, presence: true
  validates :host, presence: true
  validates :opponent, presence: true, if: 'offline == false'

  # Scopes
  scope :last_week, -> { where(updated_at: (1.week.ago)..(Time.zone.now)) }
  scope :against, -> (opponent) { where('host_id = ? OR opponent_id = ?', opponent, opponent) }

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
    game_questions.each do |question|
      next unless question.host_answer && question.host_answer.correct?
      sum += question.host_points
    end
    sum
  end

  def opponent_points
    sum = 0
    game_questions.each do |question|
      next unless question.opponent_answer && question.opponent_answer.correct?
      sum += question.opponent_points
    end
    sum
  end

  # Returns an array where each element is answer time or nil if the answer was incorrect
  # Example: [1, 2, nil, 3, 4, nil]
  def player_answers(player)
    game_questions.map do |question|
      question.player_time(player) if question.player_answer_correct?(player)
    end
  end

  def player_lobby_id(player)
    lobby = lobbies.find_by(player: player)
    lobby.id if lobby
  end

  def recent?
    updated_at.between?(1.week.ago, Time.zone.now)
  end

  def host?(player)
    player == host
  end

  def draw?
    host_points == opponent_points
  end

  def winner?(player)
    if host?(player)
      host_points > opponent_points
    else
      opponent_points > host_points
    end
  end

  def early_winner?(player)
    return false unless winner?(player)

    (host_points - opponent_points).abs > 40
  end

  def challenge?
    lobbies.first.try(:challenge?)
  end

  def close(current_player)
    push_challenge_results if challenge? && offline?

    update(closed: true, finisher: current_player)
    finisher.topic_results.find_or_create_by(topic: topic).add_session_results(self)
    update_stats
  end

  private

  def push_challenge_results
    message = "#{opponent} принял ваш вызов"
    options = { action: 'CHALLENGE_FINISHED', game_session: as_json }
    Notifier.new(host, message, options)
  end

  def update_stats
    finisher.stats.increment_consecutive_days
    finisher.stats.increment_early_winner(self)
  end

  def generate_session
    questions = Question.where(topic: topic).sample(6)
    questions.map! { |question| game_questions.build(question: question) }
    game_questions.each(&:generate_for_offline) if offline?
    save
  end
end
