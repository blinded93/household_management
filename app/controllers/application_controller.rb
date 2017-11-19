class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_member, :current_household, :logged_in?, :head_of_household?, :admin?, :selected_tab, :selected_scope

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

  def admin?
    session[:admin]
  end

  def correct_parent
    parent_key = params.keys.find{|key| key.include?("_id")}.to_sym
    parent = parent_key.slice(0..-4)
    unless params[parent_key].to_i == self.send("current_#{parent}").id
      params[parent_key] = self.send("current_#{parent}").id
    end
  end

  def selected_tab
    params[:tab]
  end

  def selected_scope
    params[:scope]
  end
end
