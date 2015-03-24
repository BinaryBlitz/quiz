# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Answer, type: :model do
  before { @answer = build(:answer) }

  it { should validate_presence_of(:content) }
end

describe Answer, 'Associations' do
  it { should have_many(:game_session_questions) }
  it { should belong_to(:question) }
end
