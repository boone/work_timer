class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_events
    @current_events = Event.current
  end
  helper_method :current_events
end
