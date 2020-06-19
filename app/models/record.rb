class Record < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :blog
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :artists
  extend FriendlyId
  friendly_id :display_name, use: :slugged
  has_one_attached :image
  validate :acceptable_image
  validates :title, presence: true
  validates :display_name, presence: true, uniqueness: { scope: :blog_id }
  validates :blog, presence: true
  before_save :set_published_at

  scope :published,  ->() { where(published: true) }
  scope :by_tag, -> (tag) { tagged_with(tag) } 
  def acceptable_image
    return unless image.attached?
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG or PNG")
    end
  end

  def set_published_at
    if self.published
      self.published_at ||= Time.current.utc
    end
  end
  
end
