# == Schema Information
#
# Table name: category_results
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  category_id   :integer
#  points        :integer          default("0")
#  weekly_points :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe CategoryResult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
