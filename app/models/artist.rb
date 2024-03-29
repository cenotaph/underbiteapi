class Artist < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :alphabetical_name, presence: true
  before_validation :fill_alphabetical
  has_and_belongs_to_many :records

  def fill_alphabetical
    return unless alphabetical_name.blank?

    self.alphabetical_name ||= name
  end
end
