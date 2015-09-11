class ParticipationPolicy < ApplicationPolicy
  def create?
    record.room.players.count < (record.room.size || 5)
  end
end
