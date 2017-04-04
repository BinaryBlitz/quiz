class Notifier
  def initialize(player, message, options = {})
    return unless player.device_token.present?

    @player = player
    @device_token = player.device_token
    @message = message
    @options = options

    push
  end

  def push
    return if @message.blank? || @device_token.blank?

    Rails.logger.debug "#{Time.zone.now} Notifying #{@player.id} with message: #{@message}"
    push_ios_notification
  end

  private

  def push_ios_notification
    notification = Houston::Notification.new(
      token: @device_token,
      alert: @message, badge: 1, custom_data: @options
    )
    client.push(notification)

    Rails.logger.debug "#{Time.zone.now} iOS notification: #{@message}, player: #{@player.id}"
  end
end
