require 'active_record'
require 'active_support/concern'

module Geospatials
  module Geospatiables
    extend ActiveSupport::Concern
    module ClassMethods
      def acts_as_geospatial(options = {})
        cattr_accessor :geospatial_unit, :lat_column_name, :lng_column_name, :full_lat_column_name, :full_lng_column_name, :geo_method

        self.geo_method = options[:geo_method] || Geospatials::GeospatialUtils::DEFAULT_GEO_METHOD
        self.geospatial_unit = options[:geospatial_unit] || Geospatials::GeospatialUtils::DEFAULT_GEOSPATIAL_UNIT
        self.lng_column_name = options[:lng_column_name] || Geospatials::GeospatialUtils::DEFAULT_LNG_COLUMN_NAME
        self.lat_column_name = options[:lat_column_name] || Geospatials::GeospatialUtils::DEFAULT_LAT_COLUMN_NAME
        self.full_lat_column_name = "#{self.table_name}.#{self.lat_column_name}"
        self.full_lng_column_name = "#{self.table_name}.#{self.lng_column_name}"

        if self.geo_method == :postgis
          after_create :set_geospatial_geometry
          after_update :set_geospatial_geometry, if: proc {(self.changes & [self.lat_column_name, self.lng_column_name]).any?}
        end

        validates self.lat_column_name, presence: true, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
        validates self.lng_column_name, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
      end

      def within(lng, lat, radius)
        where(within_query(lng, lat, radius))
      end

      private

      # Comparison between EarthDistance and Postgis:
      # https://hashrocket.com/blog/posts/juxtaposing-earthdistance-and-postgis
      def within_query(lng, lat, radius)
        Geospatials::GeospatialUtils::GEO_METHODS_CLASSES[self.geo_method]
            .within_query(lng,
                          lat,
                          radius,
                          Geospatials::GeospatialUtils::METER_CONVERTORS_FACTOR[self.geospatial_unit],
                          {
                              full_lng_column_name: self.full_lng_column_name,
                              full_lat_column_name: self.full_lat_column_name
                          })
      end
    end

    private

    def set_geospatial_geometry
      update_query = Geospatials::GeoQueries::PostgisGeoQueries
                         .geospatial_geometry_update_query(self.class.table_name,
                                                           self.class.full_lng_column_name,
                                                           self.class.full_lat_column_name,
                                                           self.id)
      ActiveRecord::Base.connection.execute(update_query)
    end
  end
end