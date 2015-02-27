# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  imei            :string
#  points          :integer          default("0")
#  weekly_points   :integer          default("0")
#

require 'rails_helper'

RSpec.describe Player, type: :model do
  before do
    @host = create(:host)
    @opponent = create(:opponent)
  end

  it { should validate_presence_of(:name) }
  # it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  # it { should validate_presence_of(:password_digest) }

  context 'should not be valid' do
    it 'with already existing email' do
      @opponent.email = @host.email.upcase
      expect(@opponent).not_to be_valid
    end

    it 'when email format is incorrect' do
      invalid_emails = %w(foobar foo@bar.1com email.com @.email@bar.com)
      invalid_emails.each do |email|
        @host.email = email
        expect(@host).not_to be_valid
      end
    end
  end
end

describe Player, 'Associations' do
  it { should have_one(:api_key) }
  it { should have_many(:lobbies) }
  it { should have_many(:host_game_sessions) }
  it { should have_many(:opponent_game_sessions) }
end
