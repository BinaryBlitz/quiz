class Topic < ActiveRecord::Base
  belongs_to :category
  has_many :questions

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :played_count, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true
end
