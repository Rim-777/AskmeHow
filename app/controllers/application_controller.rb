require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render nothing: true, alert: exception.message
  end

  check_authorization unless: :devise_controller?
end
