class ClientsController < ApplicationController
  def create
    render :json => params[:test_object].inject({}) { |result, (k, v)|
      result[k] = "created-#{v}"
      result
    }
  end

  def index
    result = []

    (0..1).each do |i|
      result[i] = params[:test_object].inject({}) { |h, (k, v)|
        h[k] = "#{i}-#{v}"
        h
      }
    end

    render :json => result
  end

  def update
    render :json => params[:test_object].inject({:id => params[:id]}) { |result, (k, v)|
      result[k] = "updated-#{v}"
      result
    }
  end

  def destroy
    render :json => {:id => params[:id], :deleted => true}
  end
end

