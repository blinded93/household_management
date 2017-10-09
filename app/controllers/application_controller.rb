class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_member, :current_household, :logged_in?, :head_of_household?, :menu_partial

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

  def head_of_household?
    current_member.head_of_household
  end

  def menu_partial
    @partial ||= session[:menu_partial]
  end
end
