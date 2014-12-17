class Session < ActiveRecord::Base
  belongs_to :player

  validates :presence, player: true
end
