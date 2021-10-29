class ActorTypesController < ApplicationController
  before_action :set_and_authorize_actor_type, only: [:show]

  # GET /actor_types
  def index
    @actor_types = policy_scope(base_object).order(created_at: :desc).page(params[:page])
    authorize @actor_types

    render json: serialize(@actor_types)
  end

  # GET /actor_types/1
  def show
    render json: serialize(@actor_type)
  end

  private

  def set_and_authorize_actor_type
    @actor_type = policy_scope(base_object).find(params[:id])
    authorize @actor_type
  end

  def base_object
    ActorType
  end

  def serialize(target, serializer: ActorTypeSerializer)
    super
  end
end
