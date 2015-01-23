# == Schema Information
#
# Table name: topics
#
#  id           :integer          not null, primary key
#  name         :string
#  visible      :boolean          default("false")
#  expires_at   :date
#  price        :integer          default("0")
#  played_count :integer          default("0")
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Topic < ActiveRecord::Base
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  has_many :lobbies

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :played_count, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true
end
