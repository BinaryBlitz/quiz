class ParticipationPolicy < ApplicationPolicy
  def create?
    record.room.players.count < record.room.size
  end
end
