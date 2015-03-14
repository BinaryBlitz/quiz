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

FactoryGirl.define do
  factory :push_token do
    token "MyString"
android false
player nil
  end

end
