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

FactoryGirl.define do
  factory :category_result do
    player nil
category nil
  end

end
