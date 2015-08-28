# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#  image      :string
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = questions(:capital_of_the_uk)
    @answer = answers(:correct)
  end
end
