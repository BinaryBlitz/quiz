class BadgeObserver
  def update(changed_data)
    badge = Merit::Badge.find(changed_data[:merit_object].badge_id)
    player = Player.find_by(sash_id: changed_data[:sash_id])
    player.push_achievement(badge)
  end
end
