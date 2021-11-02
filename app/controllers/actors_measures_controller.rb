class ActorsMeasuresController < ApplicationController
  # GET /actors_measures/:id
  def show
    @actor_measure = policy_scope(base_object).find(params[:id])
    authorize @actor_measure
    render json: serialize(@actor_measure)
  end

  # GET /actors_measures
  def index
    @actors_measures = policy_scope(base_object).all
    authorize @actors_measures
    render json: serialize(@actors_measures)
  end

  private

  def base_object
    ActorMeasure
  end

  def serialize(target, serializer: ActorMeasureSerializer)
    super
  end
end
