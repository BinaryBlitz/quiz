# == Schema Information
#
# Table name: topics
#
#  id           :integer          not null, primary key
#  name         :string
#  visible      :boolean          default(FALSE)
#  expires_at   :date
#  price        :integer          default(0)
#  played_count :integer          default(0)
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  featured     :boolean          default(FALSE)
#

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @geography = topics(:geography)
    @paid = topics(:paid)
  end

  test 'invalid without category' do
    @geography.category = nil
    assert @geography.invalid?
  end

  test 'invalid when price is negative' do
    @paid.price = -1
    assert @paid.invalid?
  end
end
