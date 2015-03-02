# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  has_many :category_results
  has_many :players, -> { uniq }, through: :category_results

  validates :name, presence: true

  def to_s
    name
  end
end
