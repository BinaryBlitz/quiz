class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :topic

  validates :content, presence: true
  validates :topic, presence: true
  validates :bounty, numericality: { greater_than_or_equal_to: 0 }
end
