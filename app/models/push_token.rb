class PushToken < ActiveRecord::Base
  belongs_to :player

  validates :token, uniqueness: true
end
