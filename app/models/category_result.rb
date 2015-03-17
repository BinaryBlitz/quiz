# == Schema Information
#
# Table name: category_results
#
#  id            :integer          not null, primary key
#  player_id     :integer
#  category_id   :integer
#  points        :integer          default(0)
#  weekly_points :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CategoryResult < ActiveRecord::Base
  belongs_to :player
  belongs_to :category

  def add(result)
    update!(points: points + result)
  end
end
