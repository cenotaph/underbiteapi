class Record < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :display_name, use: :slugged

  belongs_to :blog
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :artists
  has_one_base64_attached :image

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

  def related
    [ artists.map(&:records).flatten.delete_if{|x| x == self }.map{|x| [x.blog.slug, x.slug, x.image.url, x.display_name ].flatten }, labels.map(&:records).flatten.delete_if{|x| x == self }.map{|x| [x.blog.slug, x.slug, x.image.url, x.display_name ].flatten} ].flatten(1).uniq.compact.delete_if{|x| x.published != true }
  end
  

  def set_published_at
    if self.published
      self.published_at ||= Time.current.utc
    end
  end
  
end
