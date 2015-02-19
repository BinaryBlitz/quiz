# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  imei            :string
#  points          :integer          default("0")
#  weekly_points   :integer          default("0")
#

class Player < ActiveRecord::Base
  after_create :create_key

  # Associations
  has_one :api_key, dependent: :destroy
  has_many :lobbies, dependent: :destroy
  has_many :host_game_sessions, class_name: 'GameSession', foreign_key: 'host_id'
  has_many :opponent_game_sessions, class_name: 'GameSession', foreign_key: 'opponent_id'
  has_many :results, dependent: :destroy
  has_many :topic_results
  has_many :topics, -> { uniq }, through: :topic_results

  # Validations
  has_secure_password
  validates :name, presence: true
  validates :password_digest, presence: true, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  # Scopes
  scope :order_by_points, -> { order(points: :desc) }
  scope :order_by_weekly_points, -> { order(weekly_points: :desc) }

  TOP_SIZE = 20

  def game_sessions
    GameSession.where('host_id = ? OR opponent_id = ?', id, id)
  end

  def token
    api_key.token
  end

  def reset_weekly_points
    topic_results.each do |result|
      result.update(weekly_points: 0)
    end
  end

  def topic_points(topic)
    topic_results.find_by_topic_id(topic).points
  end

  def weekly_topic_points(topic)
    topic_results.find_by_topic_id(topic).weekly_points
  end

  # Scope methods

  def self.order_by_topic(topic)
    joins(:topic_results).where('topic_id = ?', topic.id).order('topic_results.points DESC')
  end

  def self.order_by_weekly_topic(topic)
    joins(:topic_results).where('topic_id = ?', topic.id).order('topic_results.weekly_points DESC')
  end

  private

  def create_key
    create_api_key
  end
end
