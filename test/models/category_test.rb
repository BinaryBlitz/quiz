# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
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
end
