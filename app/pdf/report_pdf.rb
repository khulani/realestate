class ReportPdf < Prawn::Document
  def initialize user
    super()
    @user = user
    if @user.account_type == 'admin'
      admin_report
    elsif @user.account_type == 'agent'
      agent_report
    else
      customer_report
    end
  end

  def admin_report
    text "Latest User Activities", size: 24, style: :bold
    move_down 10
    rows = [['Date', 'User', 'Event']]
    rows += Activity.order(date: :desc).limit(20).map do |activity|
      [activity.date.to_s, activity.user.try(:username) || activity.user_id.to_s,
        activity.event.to_s]
    end
    table rows do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def agent_report
    text "Properties You Represent", size: 24, style: :bold
    move_down 10
    rows = [['Name', 'Street', 'City', 'State', 'Agent', 'Status', 'Resident']]
    rows += @user.properties_available.map do |property|
      [property.name, property.street, property.city, property.state,
        property.agent.try(:username) || property.agent_id.to_s, property.status,
        property.resident.try(:username) || property.try(:resident_id).to_s]
    end
    table rows do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def customer_report
    text "Properties You Own or Rent", size: 24, style: :bold
    move_down 10
    rows = [['Name', 'Street', 'City', 'State', 'Agent', 'Status', 'Resident']]
    rows += @user.properties_in_use.map do |property|
      [property.name, property.street, property.city, property.state,
        property.agent.try(:username) || property.agent_id.to_s, property.status,
        property.resident.try(:username) || property.try(:resident_id).to_s]
    end
    table rows do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end
end
