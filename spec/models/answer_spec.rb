# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Answer, :type => :model do
  before do
    @answer = FactoryGirl.create(:answer)
  end

  it "should not be valid without content" do
    @answer.content = ''
    expect(@answer).not_to be_valid
  end
end
