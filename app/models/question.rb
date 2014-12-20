# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  text           :string
#  answers        :string           default("{}"), is an Array
#  correct_answer :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Question < ActiveRecord::Base
  has_many :answers

  validates :content, presence: true
  # validates :answers, presence: true
end
