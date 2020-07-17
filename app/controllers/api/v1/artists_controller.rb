# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class ArtistsController < ApiController
    before_action :authenticate_user!

    def create
      @artist = Artist.new(artist_params)
      if @artist.save
        render json: ArtistSerializer.new(@artist).serialized_json, status: 201
      end
    end
    
    def index
      @artists = Artist.all.order("lower(alphabetical_name)")
      render json: ArtistSerializer.new(@artists).serialized_json, status: 200
    end

    def show
      @artist = Artist.friendly.find(params[:id])
      render json: ArtistSerializer.new(@artist).serialized_json, status: 200
    end
    

    protected

    def artist_params
      params.permit(:name, :alphabetical_name)
    end
    
  end
end
    