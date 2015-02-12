class Result < ActiveRecord::Base
  belongs_to :player
  belongs_to :topic
end
