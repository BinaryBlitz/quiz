# == Schema Information
#
# Table name: push_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  android    :boolean          default("false")
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PushToken < ActiveRecord::Base
  belongs_to :player

  validates :token, uniqueness: true
end
