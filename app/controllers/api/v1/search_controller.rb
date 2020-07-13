# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class SearchController < ApiController
    skip_before_action :verify_authenticity_token
    def index
      @records = Record.basic_search params[:search]
      render json: RecordSerializer.new(@records).serialized_json, status: 200
    end
  end
end
