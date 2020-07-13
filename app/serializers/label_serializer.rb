class LabelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug
end
