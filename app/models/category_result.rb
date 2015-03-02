class CategoryResult < ActiveRecord::Base
  belongs_to :player
  belongs_to :category
end
