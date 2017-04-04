class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :random, -> (number = nil) { number ? order('RANDOM()').limit(number) : order('RANDOM()') }
end
