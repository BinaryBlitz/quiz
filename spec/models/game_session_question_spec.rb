# == Schema Information
#
# Table name: game_session_questions
#
#  id                 :integer          not null, primary key
#  game_session_id    :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer
#  opponent_time      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe GameSessionQuestion, :type => :model do
  before { @sq = create(:game_session_question) }

  it { should validate_presence_of(:game_session) }
  it { should validate_presence_of(:question) }

  it 'should not be valid with negative host time' do
    @sq.host_time = -1
    expect(@sq).not_to be_valid
  end

  it 'should not be valid with negative opponent time' do
    @sq.opponent_time = -1
    expect(@sq).not_to be_valid
  end

  it 'should generate a valid session question for offline mode' do
    @sq.generate_for_offline
    expect(@sq.opponent_time).to be > 0
    expect(@sq.opponent_answer_id).not_to be nil
  end

  describe 'private methods' do
    it 'loads or generates answers properly' do
      answer_and_time = @sq.send(:load_or_generate_answer)
      expect(answer_and_time).not_to be_nil
      expect(answer_and_time.size).to be == 2
      expect(answer_and_time[0].class).to equal(Answer)
      expect(answer_and_time[1]).to be > 0
    end

    it 'checks if there are session questions with online answers' do
      online_answers = @sq.send(:online_answers?)
      expect([true, false]).to include(!online_answers.nil?)
    end

    it 'generates offline answers properly' do
      answer = @sq.send(:generate_answer)
      expect(answer.class).to equal(Answer)
      expect(answer.correct).not_to be_nil
    end

    it 'generates random time properly' do
      5.times do
        random_time = @sq.send(:random_time)
        expect(random_time).to be_between(1, 6)
      end
    end
  end
end
