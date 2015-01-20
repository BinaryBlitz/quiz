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

require 'rails_helper'

RSpec.describe Question, :type => :model do
  before do
    @question = create(:question)
  end

  it "should not be valid without content" do
    @question.content = ''
    expect(@question).not_to be_valid
  end

  it "should not be valid with negative bounty" do
    @question.bounty = -1
    expect(@question).not_to be_valid
  end

  it "should not be valid without topic" do
    @question.topic = nil
    expect(@question).not_to be_valid
  end

  it "should not be valid with invalid image url" do
    @question.image_url = 'invalid url'
    expect(@question).not_to be_valid
  end
end
