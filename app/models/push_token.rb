# == Schema Information
#
# Table name: push_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  android    :boolean          default(FALSE)
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PushToken < ActiveRecord::Base
  before_validation :ensure_uniqueness

  belongs_to :player

  validates :token, uniqueness: true

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
    push_token = PushToken.find_by(token: token)
    push_token.destroy if push_token
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
    notification.sound = 'sosumi.aiff'
    APN.push(notification)
    logger.debug "iOS push sent to #{player}"
  rescue
    logger.debug "iOS push to #{player} failed"
  end
end
