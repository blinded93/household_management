class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_methods :current_member, :current_household, :logged_in?

  def current_member
    @current_member ||= Member.find_by(id: session[:member_id])
  end

  def current_household
    @current_household ||= current_member.household
  end

  def logged_in?
    !!current_member
  end

  def redirect_unless_logged_in
    unless logged_in?
      redirect_to login_path, notice:"You must be logged in."
    end
  end
end
