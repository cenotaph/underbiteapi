# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class RecordsController < ApiController
    has_scope :by_tag

    def index
      if params[:blog_id]
        @blog = Blog.friendly.find(params[:blog_id])
        @records = apply_scopes(@blog.records.published.order(published_at: :desc)).page(params[:page]).per(20)
      else
        @records = apply_scopes(Record.published.order(published_at: :desc)).page(params[:page]).per(20)
      end
      render json: RecordSerializer.new(@records).serialized_json, status: 200
    end

  end
end

    