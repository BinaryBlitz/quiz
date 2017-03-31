# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  visible     :boolean          default(TRUE)
#  expires_at  :date
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  featured    :boolean          default(FALSE)
#  paid        :boolean          default(FALSE)
#

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @geography = topics(:geography)
    @paid = topics(:paid)
  end

  # TODO: Add tests
end
