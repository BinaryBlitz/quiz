# == Schema Information
#
# Table name: sessions
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  opponent_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :host, class_name: 'Player', foreign_key: 'host_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'

  has_many :session_questions, dependent: :destroy
  has_many :questions, through: :session_questions

  validates :host, presence: true
end
