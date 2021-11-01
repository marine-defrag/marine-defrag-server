class ActorTypesTaxonomiesController < ApplicationController
  # GET /actor_types_taxonomies/:id
  def show
    @actor_type_taxonomy = policy_scope(base_object).find(params[:id])
    authorize @actor_type_taxonomy
    render json: serialize(@actor_type_taxonomy)
  end

  # GET /actor_types_taxonomies
  def index
    @actor_type_taxonomies = policy_scope(base_object).all
    authorize @actor_type_taxonomies
    render json: serialize(@actor_type_taxonomies)
  end

  private

  def base_object
    ActorTypeTaxonomy
  end

  def serialize(target, serializer: ActorTypeTaxonomySerializer)
    super
  end
end
