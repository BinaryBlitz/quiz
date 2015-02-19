# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  token      :string
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :api_key do
    token 'foobar'
  end
end
