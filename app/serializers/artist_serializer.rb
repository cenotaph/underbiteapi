class ArtistSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :alphabetical_name, :slug, :id
end
