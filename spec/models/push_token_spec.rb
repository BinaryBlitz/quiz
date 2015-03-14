# == Schema Information
#
# Table name: push_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  android    :boolean          default("false")
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PushToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
