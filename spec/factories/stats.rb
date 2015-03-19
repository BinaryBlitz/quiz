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
#

FactoryGirl.define do
  factory :stat, class: 'Stats' do
    days_in_a_row 1
    played_at '2015-03-17'
    player nil
  end
end
