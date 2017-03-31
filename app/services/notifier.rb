class Notifier
  def initialize(player, message, options = {})
    @player = player
    @device_tokens = []
    @message = message
    @options = options
  end

  def push
    return if @message.blank?

    Rails.logger.debug "#{Time.zone.now} Notifying #{@player} with message: #{@message}"

    android_tokens = @device_tokens.where(platform: 'android')
    push_android_notifications(android_tokens)
    ios_tokens = @device_tokens.where(platform: 'ios')
    push_ios_notifications(ios_tokens)
  end

  private

  def push_android_notifications(tokens)
    return if tokens.blank?

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name('android_app')
    n.registration_ids = tokens.map(&:token)
    n.data = { message: @message }.merge(@options)
    n.save!

    Rails.logger.debug "#{Time.zone.now} Android notification: #{@message}, options: #{@options}"
  end

  def push_ios_notifications(tokens)
    return if tokens.blank?

    tokens.each do |token|
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name('ios_app')
      n.device_token = token.token
      n.alert = @message
      n.data = @options
      n.save!

      Rails.logger.debug "#{Time.zone.now} Apple notification: #{@message}, options: #{@options}"
    end
  end
end
