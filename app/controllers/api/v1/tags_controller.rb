# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class TagsController < ApiController

    def index
      @taggings = Record.all.tag_counts_on(:tags).order("lower(name)")
      render json: TagsSerializer.new(@taggings).serialized_json, status: 200
    end
  end
end
    