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

  def generate
    # Offline only for now
    self.offline = true

    questions = Question.where(topic: topic).sample(6)
    questions.map!{ |q| self.game_session_questions.create(question: q) }
    questions.each{ |q| q.generate_for_offline(self) } if offline
  end
end
