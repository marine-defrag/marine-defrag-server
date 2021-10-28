class MeasureTypesController < ApplicationController
  before_action :set_and_authorize_measure_type, only: [:show]

  # GET /measure_types
  def index
    @measure_types = policy_scope(base_object).order(created_at: :desc).page(params[:page])
    authorize @measure_types

    render json: serialize(@measure_types)
  end

  # GET /measure_types/1
  def show
    render json: serialize(@measure_type)
  end

  private

  def set_and_authorize_measure_type
    @measure_type = policy_scope(base_object).find(params[:id])
    authorize @measure_type
  end

  def base_object
    MeasureType
  end

  def serialize(target, serializer: MeasureTypeSerializer)
    super
  end
end
