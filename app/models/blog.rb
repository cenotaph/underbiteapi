class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  has_many :records
end
