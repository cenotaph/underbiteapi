class TagsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :taggings_count
end
