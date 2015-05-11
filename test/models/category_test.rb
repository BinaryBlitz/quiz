# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  background :string
#  banner     :string
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:general)
  end

  test 'invalid without name' do
    @category.name = ''
    assert_not @category.valid?
  end
end
