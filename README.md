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
        
Some code comments where added for explaining the differences between the 3 ways + some other design decisions.

Initializing the setup of this module is in the Property Model itself, and you can switch the query method with the parameter `geo_method` passed to the method: `acts_as_geospatial`, to be one of the 3:
- `:postgis`
- `:haversine`
- `:earth_distance`

**Running Tests**

     RAILS_ENV=test rake db:drop db:create db:migrate
     rspec

**Endpoint**
    
    [GET] /api/v1/properties/search
    
    Request Params:
    ---------------
        :lat
            - manditory, validation: (-90 <= value <= 90)
        :lng 
            - manditory, validation: (-180 <= value <= 180)
        :property_type
            - manditory, validation: (inclusion in: ['apartment', 'single_family_house'])
        :marketing_type
            - manditory, validation: (inclusion in: ['rent', 'sell'])
        :radius
            - optional, validation: (decimal in Kilometers)
     
    Response:
    ---------
        Success:
        --------
               {
                   "successful" => true,
                   "result_data" => {
                        "properties" => [
                                          {
                                        
                                            house_number: "31", 
                                            street: "Marienburger Straße", 
                                            city: "Berlin", 
                                            zip_code: "10405
                                            state: "Berlin",
                                            lat: '13.4211476',
                                            lng: '52.534993',
                                            price: '350000'
                                          },
                                          {
                                        
                                            house_number: "16", 
                                            street: "Winsstraße", 
                                            city: "Berlin", 
                                            zip_code: "10405"
                                            state: "Berlin",
                                            lat: '52.533533',
                                            lng: '13.425226',
                                            price: '320400'
                                        
                                          }
                                         # ... other properties 
                                        ]
                   }
               }
        
        Errors:
        -------
                {
                    "successful" => false,
                    "error" => "Error Msg"
                }            

