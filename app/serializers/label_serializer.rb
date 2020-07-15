class LabelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug, :id
end
