module Geospatials
  module GeoQueries
    # Because being most accurate for any radius (Can be more accurate using ST_Distance_Spheroid)
    # and best performance (specially with the saving of the coordinated in terms of geometry and indexing it)
    # but adding dependency of Postgis over Postgres
    class PostgisGeoQueries
      def self.within_query(lng, lat, radius, meter_conversion_factor, _options = {})
        query = <<-SQL
          ST_DistanceSphere(geospatial_geometry, ST_MakePoint(%{lng}, %{lat})) <= %{radius_in_meters}
        SQL
        query % {lng: lng,
                 lat: lat,
                 radius_in_meters: radius * meter_conversion_factor}
      end

      def self.geospatial_geometry_update_query(table, full_lng_column_name, full_lat_column_name, id)
        query = <<-SQL
          UPDATE %{table_identifier}
          SET geospatial_geometry = ST_SetSRID(ST_Point(%{lng_column_name}, %{lat_column_name}), %{coordinates_sys})
          WHERE id = %{row_id}
        SQL
        query % {table_identifier: table,
                 lng_column_name: full_lng_column_name,
                 lat_column_name: full_lat_column_name,
                 coordinates_sys: GeospatialUtils::DEFAULT_COORDINATES_SYSTEM,
                 row_id: id}
      end
    end
  end
end
