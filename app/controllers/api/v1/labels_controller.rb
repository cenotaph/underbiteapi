# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class LabelsController < ApiController
    before_action :authenticate_user!, only: :create

    def create
      @label = Label.new(label_params)
      return unless @label.save

      render json: LabelSerializer.new(@label).serialized_json, status: 201
    end

    def index
      @labels = Label.all.order('lower(name)')
      render json: LabelSerializer.new(@labels).serialized_json, status: 200
    end

    def show
      @label = Label.friendly.find(params[:id])
      render json: LabelSerializer.new(@label).serialized_json, status: 200
    end

    protected

    def label_params
      params.permit(:name)
    end
  end
end
