module Geospatials
  module GeoQueries
    # Because I just know about Haversine :p
    # But really, because the logic itself can be implemented in adapters other than Postgres
    # acceptable performance (less than other 2)
    # acceptable accuracy for small radius
    class HaversineQueries
      def self.within_query(lng, lat, radius, meter_conversion_factor, options = {})
        query = <<-SQL
          ((asin(
            sqrt(
              (sin(radians((%{lat_column_name})-(%{lat}))/2)^2)
              + (sin(radians((%{lng_column_name})-(%{lng}))/2)^2) 
              * cos(radians(%{lat})) 
              * cos(radians(%{lat_column_name}))
            )
          ) * 7926.3352) * 1609.344) <= %{radius_in_meters}
        SQL
        # query = <<-SQL.squish
        #   (acos(
        #     cos(radians(%{lat_column_name}))
        #     * cos(radians(%{lat}) )
        #     * cos(radians(%{lng}) - radians(%{lng_column_name}))
        #     + sin(radians(%{lat_column_name}))
        #     * sin(radians(%{lat}))
        #   ) * 6371) <= %{radius_in_meters}
        # SQL
        query % {lng: lng,
                 lat: lat,
                 lng_column_name: options[:full_lng_column_name],
                 lat_column_name: options[:full_lat_column_name],
                 radius_in_meters: radius * meter_conversion_factor}
      end
    end
  end
end
