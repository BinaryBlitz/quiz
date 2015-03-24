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
#  points          :integer          default(0)
#  weekly_points   :integer          default(0)
#  vk_token        :string
#  vk_id           :integer
#  sash_id         :integer
#  level           :integer          default(0)
#  avatar          :string
#

class Player < ActiveRecord::Base
  include VkAuthorization
  include Achievements
  include Notifications
  include PlayerRankings
  include PlayerTopics

  after_create :create_key
  after_create :create_stats

  # Associations
  has_merit
  has_one :api_key, dependent: :destroy
  has_one :stats, dependent: :destroy
  has_many :lobbies, dependent: :destroy
  has_many :host_game_sessions, class_name: 'GameSession', foreign_key: 'host_id'
  has_many :opponent_game_sessions, class_name: 'GameSession', foreign_key: 'opponent_id'
  has_many :push_tokens, dependent: :destroy
  has_many :purchases, dependent: :destroy

  has_many :topic_results, dependent: :destroy
  has_many :topics, -> { uniq }, through: :topic_results

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { uniq }, through: :friendships

  mount_base64_uploader :avatar, AvatarUploader

  # Validations
  has_secure_password validations: false
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :password, length: { minimum: 8 }, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    allow_blank: true

  TOP_SIZE = 20

  def game_sessions
    GameSession.where('host_id = ? OR opponent_id = ?', id, id)
  end

  def token
    api_key.token
  end

  def self.random_name
    pluck(:name).sample
  end

  def to_s
    name
  end

  private

  def create_key
    create_api_key
  end
end
