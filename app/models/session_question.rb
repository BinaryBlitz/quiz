class SessionQuestion < ActiveRecord::Base
  belongs_to :session
  belongs_to :question

  validates :session, presence: true, on: :create
  validates :question, presence: true, on: :create

  validates :player_points, numericality: { greater_than_or_equal_to: 0 }
  validates :opponent_points, numericality: { greater_than_or_equal_to: 0 }
end
