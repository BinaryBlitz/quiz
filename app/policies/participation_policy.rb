class ParticipationPolicy < ApplicationPolicy
  def initialize(player, participation)
    @player = player
    @participation = participation
    @room = @participation.room
  end

  def create?
    @room && @room.players.count < (@participation.room.size || 5)
  end

  def destroy?
    @room.player == @player || @participation.player == @player
  end
end
