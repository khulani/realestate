if @property.valid?
  json.partial! 'property', property: @property
else
  json.errors @property.errors.full_messages
end
