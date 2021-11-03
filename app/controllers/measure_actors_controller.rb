class MeasureActorsController < ApplicationController
  # GET /measure_actors/:id
  def show
    @measure_actor = policy_scope(base_object).find(params[:id])
    authorize @measure_actor
    render json: serialize(@measure_actor)
  end

  # GET /measure_actors
  def index
    @measure_actors = policy_scope(base_object).all
    authorize @measure_actors
    render json: serialize(@measure_actors)
  end

  private

  def base_object
    MeasureActor
  end

  def serialize(target, serializer: MeasureActorSerializer)
    super
  end
end
