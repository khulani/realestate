class ActivitiesController < ApplicationController
  before_action :access_status

  def index
    @activities = Activity.all
  end

  def create
    @activity = Activity.create(activity_params)
    render :show
  end

  def show
    @activity = Activity.find_by(id: params[:id])
    if @activity
      render :show
    else
      render status: 404, json: { errors: ["activity '#{params[:id]}' not found."] }
    end
  end

  def update
    @activity = Activity.find_by(id: params[:id])
    if @activity
      @activity.update(activity_params)
      render :show
    else
      render status: 404, json: { errors: ["activity '#{params[:id]}' not found."] }
    end
  end

  def destroy
    @activity = Activity.find_by(id: params[:id])
    if activity
      if activity.destroy
        render json: { status: "activity '#{params[:id]}' destroyed." }
      else
        render status: 400, json: { errors: activity.errors.full_messages }
      end
    else
      render status: 404, json: { errors: ["activity '#{params[:id]}' not found."] }
    end
  end

  def activity_params
    params.permit(:name, :street, :city, :state, :latitude, :longitude,
     :agent_id, :resident_id, :status)
  end

end
