class SessionsController < ApplicationController
  def create
    @member = Member.find_by(email: params[:email])
    if @member && @member.authenticate(params[:password])
      session[:member_id] = @member.id
      session[:menu_partial] = "layouts/member_menu"
      redirect_to member_path(@member), notice: "Welcome back!"
    else
      render :new
    end
  end

  def destroy
    unless session[:member_id].nil?
      session.clear
    end
    redirect_to root_path
  end
end
