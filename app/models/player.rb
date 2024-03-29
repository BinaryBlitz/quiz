# == Schema Information
#
# Table name: players
#
#  id                     :integer          not null, primary key
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  vk_token               :string
#  vk_id                  :integer
#  sash_id                :integer
#  level                  :integer          default(0)
#  avatar                 :string
#  username               :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  token                  :string
#  visited_at             :datetime
#  vk_avatar              :string
#  device_token           :string
#

class Player < ApplicationRecord
  include VkAuthorization
  include Achievements
  include PlayerTopics

  before_save { email.downcase! if email }

  after_create :create_stats
  after_create :set_online

  # Associations
  has_merit
  has_many :reports, dependent: :destroy
  has_many :proposals, dependent: :destroy

  # Game
  has_one :stats, dependent: :destroy
  has_many :lobbies, dependent: :destroy
  has_many :host_game_sessions, class_name: 'GameSession', foreign_key: 'host_id'
  has_many :opponent_game_sessions, class_name: 'GameSession', foreign_key: 'opponent_id'

  has_many :owned_rooms, dependent: :destroy, class_name: 'Room'
  has_many :participations, dependent: :destroy
  has_many :rooms, through: :participations
  has_many :room_answers, dependent: :destroy

  has_many :invites, dependent: :destroy
  has_many :outgoing_invites, dependent: :destroy, class_name: 'Invite', foreign_key: 'creator_id'
  has_many :invited_rooms, through: :invites, source: :room

  has_many :purchases, dependent: :destroy
  has_many :purchase_types, through: :purchases
  has_many :multiplier_purchases, -> { unexpired.multipliers }, class_name: 'Purchase'
  has_many :multipliers, through: :multiplier_purchases, source: :purchase_type

  has_many :topic_results, dependent: :destroy
  has_many :recent_topic_results, -> { recent }, class_name: 'TopicResult'
  has_many :topics, -> { uniq }, through: :topic_results

  # Social
  has_many :friend_requests, dependent: :destroy
  has_many :incoming_requests, class_name: 'FriendRequest', foreign_key: 'friend_id', dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, through: :friendships

  mount_base64_uploader :avatar, AvatarUploader
  mount_base64_uploader :vk_avatar, VkUploader

  has_secure_password
  has_secure_token
  has_secure_token :password_reset_token

  # Validations
  validates :password, length: { minimum: 6 }, allow_nil: true

  validates :username, presence: true, unless: :vk_user?
  validates :username,
            length: { minimum: 3 },uniqueness: { case_sensitive: false }, allow_nil: true
  validates :email, uniqueness: { case_sensitive: false }, allow_nil: true
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_nil: true

  scope :online, -> { where('visited_at > ?', 1.minute.ago) }

  TOP_SIZE = 20

  def self.search(query)
    where('username ILIKE :query', query: "%#{query}%")
  end

  def game_sessions
    GameSession.where('host_id = ? OR opponent_id = ?', id, id)
  end

  def self.random_username(current_user)
    Player.where.not(id: current_user.id).order('RANDOM()').first.username
  end

  def to_s
    username
  end

  def multiplier
    purchase_type = multipliers.order(multiplier: :desc).first
    purchase_type ? purchase_type.multiplier : 1
  end

  def challenges
    Lobby.joins(:game_session).where(game_sessions: { opponent_id: id }).where(closed: false)
  end

  def challenged
    lobbies.where(challenge: true)
  end

  def send_password_reset
    generate_reset_password_token
    update!(password_reset_sent_at: Time.zone.now)
    PlayerMailer.password_reset(self).deliver_now
  end

  def purchased?(purchase_type)
    p = purchases.where(purchase_type: purchase_type)
    p = p.unexpired if purchase_type.multiplier?
    p.any?
  end

  def online?
    visited_at && visited_at > 1.minute.ago
  end

  def topics_unlocked?
    purchase_types.where(topic: true).any?
  end

  def score
    @score ||= ::Score.new(self)
  end

  def push_achievement(badge)
    message = "Вы получили достижение: #{badge.name}"
    options = {
      action: 'ACHIEVEMENT',
      badge: { id: badge.id, name: badge.name, icon_url: Achievement.icon_url_for(badge) }
    }
    Notifier.new(self, message, options)
  end

  private

  def set_online
    update_column(:visited_at, Time.zone.now)
  end

  def vk_user?
    vk_id.present?
  end
end
