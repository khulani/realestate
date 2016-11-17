class RealEstateController < ApplicationController
  before_action :login_status

  def add
    property = Property.new(property_params)
    property.agent_id = @user.id
    property.save
    if property.valid?
      event = "Property added: #{property.name}"
      @user.activities.create(event: event, date: Time.now)
      flash[:errors] = [event]
    else
      flash[:errors] = property.errors.full_messages
    end
    redirect_to '/real-estate/'
  end

  def buy
    property = Property.find_by(id: params[:id])
    if property
      @user.properties_in_use << property
      property.update(status: 'sold')
      event = "Property in use: #{property.name}"
      @user.activities.create(event: event, date: Time.now)
      flash[:errors] = [event]
    else
      flash[:errors] = ["Property with id #{params[:id]} not found"]
    end
    redirect_to '/real-estate'
  end

  def rent
    property = Property.find_by(id: params[:id])
    if property
      @user.properties_in_use << property
      property.update(status: 'rented')
      event = "Property in use: #{property.name}"
      @user.activities.create(event: event, date: Time.now)
      flash[:errors] = [event]
    else
      flash[:errors] = ["Property with id #{params[:id]} not found"]
    end
    redirect_to '/real-estate'
  end

  def release
    property = @user.properties_available.find_by(id: params[:id])
    if property
      status = property.status == 'sold' ? 'for sale' : 'for rent'
      property.update(resident_id: nil, status: status)
      event = "Property released: #{property.name}"
      @user.activities.create(event: event, date: Time.now)
      flash[:errors] = [event]
    else
      flash[:errors] = ["Property not found: #{params[:id]}"]
    end
    redirect_to '/real-estate'
  end

  def delete
    if @user.account_type == 'admin'
      property = Property.find_by(id: params[:id])
    else
      property = @user.properties_available.find_by(id: params[:id])
    end
    if property && property.destroy
      event = "Property deleted: #{property.name}"
      @user.activities.create(event: event, date: Time.now)
      flash[:errors] = [event]
    else
      flash[:errors] = ["Property not found: #{params[:id]}"]
    end
    redirect_to '/real-estate/'
  end

  def property_params
    params.permit(:name, :street, :city, :state, :latitude, :longitude,
    :agent_id, :status)
  end
end
