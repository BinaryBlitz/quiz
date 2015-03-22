# == Schema Information
#
# Table name: stats
#
#  id            :integer          not null, primary key
#  days_in_a_row :integer          default(0)
#  played_at     :date
#  player_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  early_wins    :integer          default(0)
#

require 'rails_helper'

RSpec.describe Stats, type: :model do
end
