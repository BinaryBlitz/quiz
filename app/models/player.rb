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
#  vk_token        :string
#  vk_id           :integer
#

class Player < ActiveRecord::Base
  include VkAuthorization
  include Achievements

  after_create :create_key
  after_create :create_stats

  # Associations
  has_merit
  has_one :api_key, dependent: :destroy
  has_one :stats, dependent: :destroy
  has_many :lobbies, dependent: :destroy
  has_many :host_game_sessions, class_name: 'GameSession', foreign_key: 'host_id'
  has_many :opponent_game_sessions, class_name: 'GameSession', foreign_key: 'opponent_id'
  has_many :results, dependent: :destroy
  has_many :push_tokens, dependent: :destroy
  has_many :purchases, dependent: :destroy

  has_many :topic_results
  has_many :topics, -> { uniq }, through: :topic_results

  has_many :category_results
  has_many :categories, -> { uniq }, through: :category_results

  has_many :friendships
  has_many :friends, -> { uniq }, through: :friendships

  # Validations
  has_secure_password validations: false
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    allow_blank: true

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

  def category_points(category)
    category_results.find_by_category_id(category).points
  end

  def weekly_category_points(category)
    category_results.find_by_category_id(category).weekly_points
  end

  def push_friend_request_from(player)
    message = "#{player.name} added you as a friend."
    options = {
      action: 'FRIEND_REQUEST', player: { id: player.id, name: player.name }
    }
    push_notification(message, options)
  end

  def push_notification(message, options = {})
    push_tokens.each do |push_token|
      push_token.push(message, options)
    end
  end

  def self.random_name
    pluck(:name).sample
  end

  # Scope methods

  def self.order_by_topic(topic)
    joins(:topic_results).where('topic_id = ?', topic.id).order('topic_results.points DESC')
  end

  def self.order_by_weekly_topic(topic)
    joins(:topic_results).where('topic_id = ?', topic.id).order('topic_results.weekly_points DESC')
  end

  def self.order_by_category(category)
    joins(:category_results)
      .where('category_id = ?', category.id)
      .order('category_results.points DESC')
  end

  def self.order_by_weekly_category(category)
    joins(:category_results)
      .where('category_id = ?', category.id)
      .order('category_results.weekly_points DESC')
  end

  def to_s
    name
  end

  private

  def create_key
    create_api_key
  end
end
