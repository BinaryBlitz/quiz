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

  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  belongs_to :topic

  has_many :game_session_questions, dependent: :destroy
  has_many :questions, through: :game_session_questions
  has_many :lobbies, dependent: :destroy

  validates :host, presence: true
  validates :topic, presence: true

  private

  def generate
    questions = Question.where(topic: topic).sample(6)
    questions.map! { |q| game_session_questions.create(question: q) }
    game_session_questions.each(&:generate_for_offline) if offline
  end
end
