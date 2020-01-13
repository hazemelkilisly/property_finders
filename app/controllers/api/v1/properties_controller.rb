module Api
  module V1
    class PropertiesController < ApplicationController
      include Api::V1::PropertiesValidators
      before_action :validate_set_lng_lat
      before_action :validate_set_filters

      def search
        properties = Property.within(@lng, @lat, params[:radius] || Property::DEFAULT_NEAR_RADIUS)
                         .where(property_type: @property_type, marketing_type: @marketing_type)

        if properties.present?
          response_data = PropertiesPresenter.new(properties).as_json
          render json: generate_result_hash(properties: response_data)
        else
          render json: generate_errors_hash('No properties found around the sent coordinates with the sent filters.')
        end
      end
    end
  end
end