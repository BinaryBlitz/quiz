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

class RoomSession < ApplicationRecord
  after_create :generate_session

  belongs_to :room
  has_many :room_questions, dependent: :destroy

  validates :room, presence: true

  QUESTIONS_PER_PLAYER = 3

  # Players ranked by points
  def rankings
    question_results = room_questions.map(&:question_results)
    RoomSessionResult.new(question_results).rankings
  end

  # Reuse JSON partial from views
  def as_json
    RoomSessionsController.new
      .view_context
      .render('/room_sessions/room_session.jbuilder', room_session: self)
  end

  def points_for(player, topic = nil)
    # return 0 unless room.player_finished?(player)
    if topic
      questions = room_questions.joins(:question).where('questions.topic_id' => topic.id)
    else
      questions = room_questions
    end

    result = 0
    questions.each do |question|
      result += question.points_for(player)
    end
    result
  end

  private

  def generate_session
    topics = Hash.new(0)
    room.participations.map(&:topic).each { |topic| topics[topic] += QUESTIONS_PER_PLAYER }
    topics.each do |topic, number_of_questions|
      questions = Question.where(topic: topic).sample(number_of_questions)
      questions.each { |question| room_questions.create(question: question) }
    end
  end
end
