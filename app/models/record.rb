class Record < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :display_name, use: :slugged

  belongs_to :blog
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :artists
  has_one_base64_attached :image
  accepts_nested_attributes_for :artists, reject_if: ->(attributes){ attributes['slug'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :labels, reject_if: ->(attributes){ attributes['slug'].blank? }, allow_destroy: true

  validate :acceptable_image
  validates :title, presence: true
  validates :display_name, presence: true, uniqueness: { scope: :blog_id }
  validates :blog, presence: true

  before_save :set_published_at

  scope :published,  ->() { where(published: true).where(['published_at <= ?', Time.current.utc]) }
  scope :by_tag, -> (tag) { tagged_with(tag) }

  def acceptable_image
    return unless image.attached?
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG or PNG")
    end
  end

  def artists_attributes=(attributes)
    artist_ids = attributes.map{|a| a[:id] }.compact 
    artists << Artist.find(artist_ids)
    super attributes
  end


  def labels_attributes=(attributes)
    label_ids = attributes.map{|a| a[:id] }.compact 
    labels << Label.find(label_ids)
    super attributes
  end

  def related
    [ artists.map(&:records).flatten.delete_if{|x| x == self || x.published != true }.map{|x| [x.blog.slug, x.slug, x.image.url, x.display_name ].flatten }, labels.map(&:records).flatten.delete_if{|x| x == self || x.published != true }.map{|x| [x.blog.slug, x.slug, x.image.url, x.display_name ].flatten} ].flatten(1).uniq.compact
  end
  

  def set_published_at
    if self.published
      self.published_at ||= Time.current.utc
    end
  end
  
end
