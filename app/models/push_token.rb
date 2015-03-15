# == Schema Information
#
# Table name: push_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  android    :boolean          default("false")
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PushToken < ActiveRecord::Base
  belongs_to :player

  validates :token, uniqueness: true

  def push(message, options = {})
    logger.debug "Started pushing notification to #{player}"
    if android?
      push_to_android(message, options)
    else
      push_to_apple(message, options)
    end
  end

  private

  def push_to_android(message, options = {})
    data = { data: { title: 'iQuiz', message: message } }
    data[:data].merge!(options)
    GCM_INSTANCE.send(token, data)

    logger.debug "Android push sent to #{player}"
  end

  def push_to_apple(message, options = {})
    notification = Houston::Notification.new(device: token)
    notification.alert = message
    notification.custom_data = options
    APN.push(notification)

    logger.debug "iOS push sent to #{player}"
  end
end
