# == Schema Information
#
# Table name: sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  online      :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  belongs_to :topic

  has_many :session_questions, dependent: :destroy
  has_many :questions, through: :session_questions

  validates :host, presence: true
  validates :topic, presence: true

  def generate
    # Offline only for now
    self.offline = true

    6.times do
      # Avoid repetitions
      begin
        sq = SessionQuestion.new(question: Question.where(topic: topic).sample)
      end while questions.include?(sq.question)
      # Random answer and time
      sq.opponent_answer = sq.question.answers.sample
      sq.opponent_time = (2..6).to_a.sample
      sq.session = self
      sq.save

      self.session_questions << sq
    end
  end
end
