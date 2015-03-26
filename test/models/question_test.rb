# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  image_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = questions(:capital_of_the_uk)
    @answer = answers(:correct)
  end

  test 'invalid without content' do
    @question.content = ''
    assert @question.invalid?
  end
end
