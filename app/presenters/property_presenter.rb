class PropertyPresenter

  def initialize(property)
    @property = property
  end

  def as_json(*)
    {
        house_number: @property.house_number,
        street: @property.street,
        city: @property.city,
        zip_code: @property.zip_code,
        state: @property.state,
        lng: @property.lng.to_s,
        lat: @property.lat.to_s,
        price: @property.price.to_s
    }
  end
end
