class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    keys = Proc.new do |u|
      u.permit(
        { specialty_ids: [], ailment_ids: [] },
        :password, :password_confirmation, :current_password,
        :email, :first_name, :last_name,
        :street, :city, :state, :zip
      )
    end
    devise_parameter_sanitizer.for(:sign_up, &keys)
    devise_parameter_sanitizer.for(:sign_in, &keys)
    devise_parameter_sanitizer.for(:account_update, &keys)
  end
end
