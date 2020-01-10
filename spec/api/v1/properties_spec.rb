require 'spec_helper'

describe Api::V1::PropertiesController, :type => :controller do
  context 'GET #search' do
    it 'Return error in case no lat is sent' do
      get :search, params: {lng: Faker::Address.longitude, property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq("You must send both :lng and :lat attributes")
    end

    it 'Return error in case no lng is sent' do
      get :search, params: {lat: Faker::Address.latitude, property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq("You must send both :lng and :lat attributes")
    end

    it 'Return error in case no lng and no lat is sent' do
      get :search, params: {property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq("You must send both :lng and :lat attributes")
    end

    it 'Return error in case of wrong formatted lat' do
      get :search, params: {lat: '95.533533', lng: Faker::Address.longitude, property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq(":lat must be between -90 and 90 degrees")
    end

    it 'Return error in case of wrong formatted lng' do
      get :search, params: {lat: Faker::Address.latitude, lng: '185.533533', property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq(":lng must be between -180 and 180 degrees")
    end

    it 'Return error in case of wrong property_type' do
      get :search, params: {lat: Faker::Address.latitude, lng: Faker::Address.longitude, property_type: 'villa', marketing_type: 'sell'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq(":property_type must be one from: #{Property.property_types.keys.join(', ')}")
    end

    it 'Return error in case of wrong marketing_type' do
      get :search, params: {lat: Faker::Address.latitude, lng: Faker::Address.longitude, property_type: 'apartment', marketing_type: 'lease'}
      expect(response).to have_http_status(400)
      expect(jsonified_response[:error]).to eq(":marketing_type must be one from: #{Property.marketing_types.keys.join(', ')}")
    end

    it 'Return error in case of no near records with filters found' do
      get :search, params: {lat: Faker::Address.latitude, lng: Faker::Address.longitude, property_type: 'apartment', marketing_type: 'sell'}
      expect(response).to have_http_status(200)
      expect(jsonified_response[:error]).to eq("No properties found around the sent coordinates with the sent filters.")
    end

    it 'Return only near properties to the coordinates' do
      lat = Faker::Address.latitude
      lng = Faker::Address.longitude

      near_properties = create_list(:property, 5, {lat: lat, lng: lng, property_type: 'apartment', marketing_type: 'sell'})
      _not_matching_property = create(:property, {lat: lat, lng: lng, property_type: 'apartment', marketing_type: 'rent'})
      _far_property = create(:property, {lat: lat+1, lng: lng+1, property_type: 'apartment', marketing_type: 'sell'})

      get :search, params: {lat: lat, lng: lng, property_type: 'apartment', marketing_type: 'sell'}

      near_properties_coord = near_properties.map{|prop| [prop.lat.to_s, prop.lng.to_s]}
      results_coord = jsonified_response[:result_data][:properties].map{|prop| [prop[:lat], prop[:lng]]}

      expect(near_properties_coord - results_coord)
          .to be_empty
    end
  end
end