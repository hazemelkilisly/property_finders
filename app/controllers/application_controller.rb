class ApplicationController < ActionController::API

#  rescue_from Exception do |_exception|
#    render :json => generate_errors_hash('Issue happened while trying to fetch your data.'), status: 500
#  end

  private

  def generate_result_hash(result_data = {})
    {
        "successful" => true,
        "result_data" => result_data
    }
  end

  def generate_errors_hash(error_msg = '')
    {
        "successful" => false,
        "error" => error_msg
    }
  end


end
