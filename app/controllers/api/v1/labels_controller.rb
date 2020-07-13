# frozen_string_literal: true

module Api::V1
  # device types controller. admins only?
  class LabelsController < ApiController
    before_action :authenticate_user!

    def create
      @label = Label.new(label_params)
      if @label.save
        render json: LabelSerializer.new(@label).serialized_json, status: 201
      end
    end

    
    def index
      @labels = Label.all.order("lower(name)")
      render json: LabelSerializer.new(@labels).serialized_json, status: 200
    end

    protected

    def label_params
      params.permit(:name)
    end

  end
end
    