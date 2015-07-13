# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  name        :string
#  visible     :boolean          default(TRUE)
#  expires_at  :date
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  featured    :boolean          default(FALSE)
#

class Topic < ActiveRecord::Base
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  has_many :lobbies, dependent: :destroy
  has_many :topic_results, dependent: :destroy
  has_many :players, -> { uniq }, through: :topic_results

  validates :name, presence: true
  validates :category, presence: true
end
