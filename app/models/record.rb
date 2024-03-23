class Record < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  acts_as_taggable_on :tags
  extend FriendlyId
  friendly_id :display_name, use: :slugged

  belongs_to :blog
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :artists
  has_one_base64_attached :image
  accepts_nested_attributes_for :artists, reject_if: ->(attributes) { attributes['slug'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :labels, reject_if: ->(attributes) { attributes['slug'].blank? }, allow_destroy: true

  validate :acceptable_image
  validates :title, presence: true
  validates :display_name, presence: true, uniqueness: { scope: :blog_id }
  validates :blog, presence: true

  before_save :set_published_at

  scope :published, -> { where(published: true).where(['published_at <= ?', Time.current.utc]) }
  scope :by_tag, ->(tag) { tagged_with(tag) }
  scope :by_artist, ->(artist_id) { joins(:artists).where(['artists.slug = ?', artist_id]).where(published: true) }
  scope :by_label, ->(label_id) { joins(:labels).where(['labels.slug = ?', label_id]).where(published: true) }

  def acceptable_image
    return unless image.attached?

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(image.content_type)

    errors.add(:image, 'must be a JPEG or PNG')
  end

  def artists_attributes=(attributes)
    artist_ids = attributes.map { |a| a[:id] }.compact
    artists << Artist.find(artist_ids)
    super attributes
  end

  def labels_attributes=(attributes)
    label_ids = attributes.map { |a| a[:id] }.compact
    labels << Label.find(label_ids)
    super attributes
  end

  def related
    [artists.includes([:records]).map(&:records).flatten.delete_if do |x|
       x == self || x.published != true
     end.map { |x| [x.blog.slug, x.slug, x.image.url, x.display_name].flatten }, labels.includes([:records]).map(&:records).flatten.delete_if do |x|
                                                                                   x == self || x.published != true
                                                                                 end.map do |x|
                                                                                   [x.blog.slug, x.slug, x.image.url, x.display_name].flatten
                                                                                 end].flatten(1).uniq.compact
  end

  def set_published_at
    return unless published

    self.published_at ||= Time.current.utc
  end
end
