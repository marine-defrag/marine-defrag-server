class ActorMeasuresController < ApplicationController
  # GET /actor_measures/:id
  def show
    @actor_measure = policy_scope(base_object).find(params[:id])
    authorize @actor_measure
    render json: serialize(@actor_measure)
  end

  # GET /actor_measures
  def index
    @actor_measures = policy_scope(base_object).all
    authorize @actor_measures
    render json: serialize(@actor_measures)
  end

  private

  def base_object
    ActorMeasure
  end

  def serialize(target, serializer: ActorMeasureSerializer)
    super
  end
end
