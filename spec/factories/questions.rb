# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  image_url  :string
#  bounty     :integer          default("1")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

FactoryGirl.define do
  factory :question do
    content "What is the capital of the UK?"
    image_url "http://rubyonrails.org/images/rails.png"
    bounty 1
    topic
  end
end
