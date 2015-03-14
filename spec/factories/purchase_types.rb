# == Schema Information
#
# Table name: purchase_types
#
#  id         :integer          not null, primary key
#  identifier :string
#  multiplier :integer
#  topic_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :purchase_type do
    name "MyString"
  end

end
