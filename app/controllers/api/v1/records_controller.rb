# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class RecordsController < ApiController
    has_scope :by_tag
    has_scope :by_artist
    has_scope :by_label
    respond_to :json, :xml
    before_action :authenticate_user!, only: %i[create destroy update]

    def calendar
      @records = Record.published.group_by do |x|
        [x.published_at.year, x.published_at
                               .month]
      end.sort_by(&:first).reverse.to_json
      render(json: @records, status: :ok)
    end

    def create
      @record = Record.new(record_params)
      if @record.save
        @record.image.attach(data: params[:image]) if params[:image]
        render(json: RecordSerializer.new(@record, include: [:blog]).serialized_json, status: :ok)
      else
        Rails.logger.error(@record.errors.inspect)
        render(json: { error: @record.errors.inspect }, status: :unprocessable_entity)
      end
    end

    def index
      if current_user
        if params[:blog_id]
          @blog = Blog.friendly.find(params[:blog_id])
          @records = apply_scopes(@blog.records.published.order(published_at: :desc)).page(params[:page]).per(10)
        else
          @records = apply_scopes(Record.all.order(published_at: :desc)).page(params[:page]).per(10)
        end
        render(json: RecordSerializer.new(@records, include: [:blog]).serialized_json, status: :ok)
      else
        if params[:blog_id]
          @blog = Blog.friendly.find(params[:blog_id])
          @records = apply_scopes(@blog.records.published.order(published_at: :desc)).page(params[:page]).per(10)
        else
          @records = apply_scopes(Record.published.order(published_at: :desc)).page(params[:page]).per(10)
        end
        respond_to do |format|
          format.json { render(json: RecordSerializer.new(@records, include: [:blog]).serialized_json, status: :ok) }
          format.rss { render(layout: false) }
        end
      end
    end

    def show
      if params[:blog_id]
        @blog = Blog.friendly.find(params[:blog_id])
        @record = @blog.records.friendly.find(params[:id])
      else
        @record = Record.friendly.find(params[:id])
      end
      if current_user
        render(json: RecordSerializer.new(@record, include: %i[blog artists labels]).serialized_json, status: :ok)
      elsif @record.published
        render(json: RecordSerializer.new(@record, include: %i[blog artists labels]).serialized_json, status: :ok)
      else
        render(json: { error: 'Not published yet' }, status: :not_found)
      end
    end

    def update
      @record = Record.friendly.find(params[:id])
      if @record.update(record_params)
        @record.image.attach(data: params[:image]) if params[:image] !~ /^http/
        render(json: RecordSerializer.new(@record, include: [:blog]).serialized_json, status: :ok)
      else
        Rails.logger.error(@record.errors.inspect)
        render(json: { error: @record.errors.inspect }, status: :unprocessable_entity)
      end
    end

    protected

    def record_params
      params.permit(:display_name, :blog_id, :title, :published, :published_at, :tag_list, :review, artist_ids: [],
                                                                                                    label_ids: [], artists_attributes: %i[id _destroy], labels_attributes: %i[id _destroy])
    end
  end
end
