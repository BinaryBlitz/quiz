# == Schema Information
#
# Table name: session_questions
#
#  id                 :integer          not null, primary key
#  session_id         :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer          default("0")
#  opponent_time      :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe SessionQuestion, :type => :model do
  before do
    @sq = FactoryGirl.create(:session_question)
  end

  it "should not be valid without session" do
    @sq.session = nil
    expect(@sq).not_to be_valid
  end

  it "should not be valid without question" do
    @sq.question = nil
    expect(@sq).not_to be_valid
  end
end
