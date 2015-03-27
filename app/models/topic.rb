# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  name        :string
#  visible     :boolean          default(FALSE)
#  expires_at  :date
#  price       :integer          default(0)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  featured    :boolean          default(FALSE)
#

class Topic < ActiveRecord::Base
  after_create :associate_with_purchase_type

  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  has_many :lobbies
  has_many :topic_results
  has_many :players, -> { uniq }, through: :topic_results
  has_one :purchase_type, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true

  accepts_nested_attributes_for :purchase_type, reject_if: -> (a) { a[:identifier].blank? }

  private

  def associate_with_purchase_type
    PurchaseType.create(identifier: "topic-#{id}", topic: self) if price > 0 && !purchase_type
  end
end
