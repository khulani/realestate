class PropertiesController < ApplicationController
  before_action :access_status

  def index
    @properties = Property.all
  end

  def create
    @property = Property.create(property_params)
    render :show
  end

  def show
    @property = Property.find_by(id: params[:id])
    unless @property
      render status: 404, json: { errors: ["property '#{params[:id]}' not found."] }
    end
  end

  def update
    @property = Property.find_by(id: params[:id])
    if @property
      @property.update(property_params)
      render :show
    else
      render status: 404, json: { errors: ["property '#{params[:id]}' not found."] }
    end
  end

  def destroy
    property = Property.find_by(id: params[:id])
    if property
      if property.destroy
        render json: { status: "property '#{params[:id]}' destroyed." }
      else
        render status: 400, json: { errors: property.errors.full_messages }
      end
    else
      render status: 404, json: { errors: ["property '#{params[:id]}' not found."] }
    end
  end

  def property_params
    params.permit(:name, :street, :city, :state, :latitude, :longitude,
     :agent_id, :resident_id, :status)
  end

end
