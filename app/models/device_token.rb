# == Schema Information
#
# Table name: device_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  platform   :string
#

class DeviceToken < ActiveRecord::Base
  before_validation :ensure_uniqueness
  belongs_to :player

  validates :token, uniqueness: true
  validates :platform, inclusion: %w(android ios)

  def push(message, options = {})
    logger.debug "Started pushing notification to #{player} with options: #{options}"
    if android?
      push_to_android(message, options)
    else
      push_to_apple(message, options)
    end
  end

  private

  def ensure_uniqueness
    device_token = DeviceToken.find_by(token: token)
    device_token.destroy if device_token && device_token.id != id
  end

  def push_to_android(message, options = {})
    data = { data: { title: 'iQuiz', message: message } }
    data[:data].merge!(options)
    GCM_INSTANCE.send([token], data)
    logger.debug "Android push sent to #{player}"
  rescue
    logger.debug "Android push to #{player} failed"
  end

  def push_to_apple(message, options = {})
    notification = Houston::Notification.new(device: token)
    notification.alert = message
    notification.custom_data = options
    APN.push(notification)
    logger.debug "iOS push sent to #{player}"
  rescue
    logger.debug "iOS push to #{player} failed"
  end
end
