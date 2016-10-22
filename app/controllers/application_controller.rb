class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    # TODO REPLACE WITH DEVISE
  end

  def authenticate_user!
    # TODO REPLACE WITH DEVISE
    redirect_to root_path unless current_user.present?
  end
end
