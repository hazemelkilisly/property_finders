class Property < ApplicationRecord
  DEFAULT_NEAR_RADIUS = 5
  include Geospatials::Geospatiables
  acts_as_geospatial geospatial_unit: :kms, geo_method: :postgis

  enum property_type: %w(apartment single_family_house)
  enum marketing_type: %w(rent sell)

  validates :property_type, :marketing_type, :city, :zip_code, :state, :price, presence: true
  validates :price, numericality: {greater_than: 0}
end
