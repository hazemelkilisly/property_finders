class AddGeospatialGeometryToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :geospatial_geometry, :geometry
    execute "CREATE INDEX properties_geospatial_geometry ON properties USING gist(geospatial_geometry);"
  end
end
