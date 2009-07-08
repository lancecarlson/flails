class ClientsController < ApplicationController
  def create
    render :json => params[:test_object].inject({}) { |result, (k, v)|
      result[k] = "processed-#{v}"
      result
    }
  end
end

