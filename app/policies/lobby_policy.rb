class LobbyPolicy < ApplicationPolicy
  def challenge?
    topic = record.topic
    !topic.paid? || (topic.paid? && user.topics_unlocked?)
  end
end
