class RecordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :display_name, :review, :title, :blog_id, :tag_list, :published, :published_at, :slug
  has_many :artists
  has_many :labels
  attribute :blog_slug do |obj|
    obj.blog.slug
  end
  belongs_to :blog
  attributes :artists do |obj|
    obj.artists
  end
  attributes :labels do |obj|
    obj.labels
  end
  attributes :related do |obj|
    obj.related
  end
  attributes :image do |obj|
    if obj.image.attachment.nil?
      nil
    else
      obj.image.url
    end
  end
end
