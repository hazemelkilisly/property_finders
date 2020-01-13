class PropertiesPresenter

  def initialize(properties)
    @properties = Array(properties)
  end

  def as_json(*)
    @properties.map{|property| present_property(property)}
  end

  private

  def present_property(property)
    {
        house_number: property.house_number,
        street: property.street,
        city: property.city,
        zip_code: property.zip_code,
        state: property.state,
        lng: property.lng.to_s,
        lat: property.lat.to_s,
        price: property.price.to_s
    }
  end
end
