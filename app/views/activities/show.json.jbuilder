if @activity.valid?
  json.partial! 'activity', activity: @activity
else
  json.errors @activity.errors.full_messages
end
