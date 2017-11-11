class ApplicationController < ActionController::API
  def health
    render plain: "OK"
  end
end
