class ParticipationPolicy < ApplicationPolicy
  def create?
    room = record.room
    room && room.players.count < (record.room.size || 5)
  end
end
