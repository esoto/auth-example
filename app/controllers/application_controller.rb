class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    redirect_to new_session_path, alert: "You must be signed in to view this page" unless user_signed_in? 
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    user.touch(:last_sign_in_at)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end
end
