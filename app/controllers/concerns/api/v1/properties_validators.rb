module Api
  module V1
    module PropertiesValidators

      private

      def validate_set_lng_lat
        unless params[:lat].present? && params[:lng].present?
          render json: generate_errors_hash('You must send both :lng and :lat attributes'),
                 status: :bad_request
        end
        @lng = params[:lng].to_f
        unless @lng >= -180 && @lng <= 180
          render json: generate_errors_hash(':lng must be between -180 and 180 degrees'),
                 status: :bad_request
        end
        @lat = params[:lat].to_f
        unless @lat >= -90 && @lat <= 90
          render json: generate_errors_hash(':lat must be between -90 and 90 degrees'),
                 status: :bad_request
        end
      end

      def validate_set_filters
        @property_type = params[:property_type]
        allowed_property_types = Property.property_types.keys
        unless @property_type.in?(allowed_property_types)
          render json: generate_errors_hash(':property_type must be one from: ' + allowed_property_types.join(', ')),
                 status: :bad_request
        end

        @marketing_type = params[:marketing_type]
        allowed_marketing_types = Property.marketing_types.keys
        unless @marketing_type.in?(allowed_marketing_types)
          render json: generate_errors_hash(':marketing_type must be one from: ' + allowed_marketing_types.join(', ')),
                 status: :bad_request
        end
      end
    end
  end
end