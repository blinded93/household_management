class SessionsController < ApplicationController
  def new
  end

  def create
    respond_to do |format|
      if auth_hash = request.env['omniauth.auth']
        @member = Member.find_or_create_by_oauth(auth_hash['info'])
        session[:member_id] = @member.id
        format.html {
          redirect_to member_path(@member)
        }
      else
        @member = Member.find_by(email: params[:email])
        if @member && @member.authenticate(params[:password])
            session[:member_id] = @member.id
            format.html {
              redirect_to member_path(@member)
            }
        else
          format.js { render 'errors' }
        end
      end
    end
  end

  def destroy
    unless session[:member_id].nil?
      session.clear
    end
    redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end
end
