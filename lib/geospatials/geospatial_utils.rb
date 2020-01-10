module Geospatials
  class GeospatialUtils
    DEFAULT_GEOSPATIAL_UNIT = :kms
    DEFAULT_LAT_COLUMN_NAME = 'lat'
    DEFAULT_LNG_COLUMN_NAME = 'lng'
    DEFAULT_COORDINATES_SYSTEM = 4326 #EPSG:4326
    METER_CONVERTORS_FACTOR = {
        kms: 1000,
        miles: 1609.344,
    }
    DEFAULT_GEO_METHOD = :postgis
    GEO_METHODS_CLASSES = {
        postgis: Geospatials::GeoQueries::PostgisGeoQueries,
        earth_distance: Geospatials::GeoQueries::EarthDistanceQueries,
        haversine: Geospatials::GeoQueries::HaversineQueries
    }
  end
end
