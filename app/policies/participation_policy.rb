class ParticipationPolicy < ApplicationPolicy
  def initialize(player, participation)
    @player = player
    @participation = participation
    @room = @participation.room
  end

  def create?
    not_full = @room && (@room.players.count < (@participation.room.size || 5))
    visible = !@room.friends_only || @room.player.friends.include?(@player)
    not_full && visible
  end

  def destroy?
    @room.player == @player || @participation.player == @player
  end
end
