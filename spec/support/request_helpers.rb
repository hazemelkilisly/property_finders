module Support
  module RequestHelpers
    def jsonified_response
      response.body.present? ? JSON.parse(response.body).with_indifferent_access : {}
    end
  end
end
