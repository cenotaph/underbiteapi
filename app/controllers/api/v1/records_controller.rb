# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class RecordsController < ApiController
    has_scope :by_tag
    respond_to :json, :xml
    before_action :authenticate_user!, only: [:create, :destroy, :update]

    def create
      @record = Record.new(record_params)
      if @record.save
        render json: RecordSerializer.new(@records, include: [:blog]).serialized_json, status: 200
      else
        Rails.logger.error @record.errors.inspect
        render json: { error: @record.errors.inspect }, status: 422
      end
    end
    
    def index
      if current_user
        @records = apply_scopes(Record.all.order(published_at: :desc)).page(params[:page]).per(50)
        render json: RecordSerializer.new(@records, include: [:blog]).serialized_json, status: 200
      else
        if params[:blog_id]
          @blog = Blog.friendly.find(params[:blog_id])
          @records = apply_scopes(@blog.records.published.order(published_at: :desc)).page(params[:page]).per(20)
        else
          @records = apply_scopes(Record.published.order(published_at: :desc)).page(params[:page]).per(20)
        end
        respond_to do |format|
          format.rss { render layout: false }
          format.json { render json: RecordSerializer.new(@records, include: [:blog]).serialized_json, status: 200 }
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
        render json: RecordSerializer.new(@record, include: [:blog]).serialized_json, status: 200
      else
        if @record.published
          render json: RecordSerializer.new(@record, include: [:blog]).serialized_json, status: 200
        else
          render json: { error: 'Not published yet' }, status: 404
        end
      end
    end

    def update
      @record = Record.friendly.find(params[:id])
      if @record.update(record_params)
        @record.image.attach(data: params[:record][:image])
        render json: RecordSerializer.new(@record, include: [:blog]).serialized_json, status: 200
      else
        render json: { error: @record.errors.inspect.join }, status: 422
      end
    end
    
    protected

    def record_params
      params.require(:record).permit(:display_name, :blog_id, :published, :published_at, :tag_list, :review)
    end
    
  end
end

    