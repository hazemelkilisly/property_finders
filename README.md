# Property Finder

This project is intended to implement the needed querying logic for getting near geospatial points from a center coordinate.

**Decsription**

I wanted to make Querying logic to be totally separatable from the app itself.
So I moved the GeoSpatial logic into the Lib folder and divided it as the following:
    
    /lib
        * geospatial_utils.rb
            (This is a class containing all the constants needed to define the defaults of the library)
            (Defined those constant in a separate class in order not be included in the including model)
        
        * geospatiables.rb
            (This is a module to be included into geospatial models)
            (In our case, this is the property model)
        
        /geo_queries
            (Here, I defined 3 different ways for handling GeoSpatial Modules)
            (It contains Query intializing classes, only for each way/algorithm)
            * PostgisGeoQueries
                (Implementing here the PostGIS postgres extention)
                (Defined 2 methods, the 1st is for getting the distance between 2 coordinates, 2nd is for updating the geometry field representing the coordinates points)
            * HaversineQueries
                (Implementing the haversine algorithm for getting the distance between coordinates)
            * EarthDistanceQueries
                (Implementing the EarthDistance extention way for getting the earth distance between 2 points)
                (Although the query is verified to be correct, but I've not implemented the setup needed for adding the EarthDistance Postgres extention for time limitations)
        
Some code comments where added for explaining the differences between the 3 ways + some other design decisions.

Initializing the setup of this module is in the Property Model itself, and you can switch the query method with the parameter `geo_method` passed to the method: `acts_as_geospatial`, to be one of the 3:
- `:postgis`
- `:haversine`
- `:earth_distance` -> But as described above, the EarthDistance extension setup is not implemented.

**Running Tests**

     RAILS_ENV=test rake db:drop db:create db:migrate
     rspec
