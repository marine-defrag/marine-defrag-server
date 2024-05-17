class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authorize_base_object!

  # POST /feedbacks
  def create
    @feedback = Feedback.new
    @feedback.assign_attributes(permitted_attributes(@feedback))
    authorize @feedback

    if @feedback.save
      render json: serialize(@feedback), status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

  def base_object
    Feedback
  end

  def permitted_attributes(...)
    super.merge(user_id: current_user.id)
  end

  def serialize(target, serializer: FeedbackSerializer)
    super
  end

  def set_and_authorize_user
    @user = policy_scope(base_object).find(params[:id])
    authorize @user
  end
end
