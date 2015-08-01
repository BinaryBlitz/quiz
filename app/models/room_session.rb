# == Schema Information
#
# Table name: room_sessions
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  closed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoomSession < ActiveRecord::Base
  after_create :generate

  belongs_to :room

  has_many :room_questions, dependent: :destroy

  validates :room, presence: true

  QUESTIONS_PER_PLAYER = 3

  # Players ranked by points
  def rankings
    question_results = room_questions.map(&:question_results)

    result = RoomSessionResult.new
    question_results.each { |answer| result.add(answer[:player], answer[:points]) }
    result.rankings
  end

  def as_json
    # Reuse JSON partial from views
    RoomSessionsController.new
      .view_context
      .render('/room_sessions/room_session.jbuilder', room_session: self)
  end

  def points_for(player)
    # return 0 unless room.player_finished?(player)

    result = 0
    room_questions.each do |question|
      result += question.points_for(player)
    end
    result
  end

  private

  def generate
    topics = Hash.new(0)
    room.participations.map(&:topic).each { |topic| topics[topic] += QUESTIONS_PER_PLAYER }
    topics.each do |topic, number_of_questions|
      questions = Question.where(topic: topic).sample(number_of_questions)
      questions.each { |question| room_questions.create(question: question) }
    end
  end
end
