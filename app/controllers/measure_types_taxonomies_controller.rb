class MeasureTypesTaxonomiesController < ApplicationController
  # GET /measure_types_taxonomies/:id
  def show
    @measure_type_taxonomy = policy_scope(base_object).find(params[:id])
    authorize @measure_type_taxonomy
    render json: serialize(@measure_type_taxonomy)
  end

  # GET /measure_types_taxonomies
  def index
    @measure_type_taxonomies = policy_scope(base_object).all
    authorize @measure_type_taxonomies
    render json: serialize(@measure_type_taxonomies)
  end

  private

  def base_object
    MeasureTypeTaxonomy
  end

  def serialize(target, serializer: MeasureTypeTaxonomySerializer)
    super
  end
end
