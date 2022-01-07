class ResourcesController < ApplicationController
  before_action :set_and_authorize_resource, only: [:show, :update, :destroy]

  # GET /resources
  def index
    @resources = policy_scope(base_object).order(created_at: :desc)
    authorize @resources

    render json: serialize(@resources)
  end

  # GET /resources/1
  def show
    render json: serialize(@resource)
  end

  # POST /resources
  def create
    @resource = Resource.new
    @resource.assign_attributes(permitted_attributes(@resource))
    authorize @resource

    if @resource.save
      render json: serialize(@resource), status: :created, location: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resources/1
  def update
    if params[:resource][:updated_at] && DateTime.parse(params[:resource][:updated_at]).to_i != @resource.updated_at.to_i
      return render json: '{"error":"Record outdated"}', status: :unprocessable_entity
    end
    if @resource.update!(permitted_attributes(@resource))
      set_and_authorize_resource
      render json: serialize(@resource)
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_and_authorize_resource
    @resource = policy_scope(base_object).find(params[:id])
    authorize @resource
  end

  def base_object
    Resource
  end

  def serialize(target, serializer: ResourceSerializer)
    super
  end
end
