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

  def rankings
    question_results = room_questions.map(&:question_results)

    result = RoomSessionResult.new
    question_results.each { |answer| result.add(answer[:player], answer[:points]) }
    result.rankings
  end

  private

  def generate
    room.participations.each do |participation|
      questions = Question.where(topic: participation.topic).sample(QUESTIONS_PER_PLAYER)
      questions.each { |question| room_questions.create(question: question) }
    end
  end
end
