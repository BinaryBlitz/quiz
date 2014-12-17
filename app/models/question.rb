class Question < ActiveRecord::Base
  validates :text, presence: true
end
