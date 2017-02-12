# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  content       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  topic_id      :integer
#  image         :string
#  reports_count :integer          default(0)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = questions(:uk_capital)
    @answer = answers(:correct)
  end
end
