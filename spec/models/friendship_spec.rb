# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  friend_id  :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Friendship, type: :model do
end
