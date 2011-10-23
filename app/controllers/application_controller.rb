class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def handle_unverified_request
    raise ActionController::InvalidAuthenticityToken
  end
  
  def current_events
    @current_events = Event.current
  end
  
  def time_today
    @time_today = Event.time_today
  end

  helper_method :current_events, :time_today
end
