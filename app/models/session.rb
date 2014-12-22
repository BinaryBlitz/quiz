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
end
