class SessionsController < ApplicationController
  def new
  end

  def create
    @member = Member.find_by(email: params[:email])
    if @member && @member.authenticate(params[:password])
      session[:member_id] = @member.id
      redirect_to household_member_path(@member.household, @member), notice: "Welcome back!"
    else
      render :new
    end
  end
end
