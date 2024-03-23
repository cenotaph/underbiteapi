class BlogSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :slug, :description
end
