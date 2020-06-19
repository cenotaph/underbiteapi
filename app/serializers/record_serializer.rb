class RecordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :display_name, :review, :tag_list, :published, :published_at
  attributes :image do |obj|
    if obj.image.attachment.nil?
      nil
    else
      obj.image.service_url
    end
  end
end
