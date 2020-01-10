module Geospatials
  module GeoQueries
    # Because no need for dependencies over Postgres
    # and very acceptable performance
    # but less accurate results for larger radius
    class EarthDistanceQueries
      def self.within_query(lng, lat, radius, meter_conversion_factor, options = {})
        query = <<-SQL
          (
            point(%{lng_column_name}, %{lat_column_name})<@>point(%{lng}, %{lat})
          ) * 1609.344 <= %{radius_in_meters}
        SQL
        query % {lng: lng,
                 lat: lat,
                 lng_column_name: options[:full_lng_column_name],
                 lat_column_name: options[:full_lat_column_name],
                 radius_in_meters: radius * meter_conversion_factor}
      end
    end
  end
end
