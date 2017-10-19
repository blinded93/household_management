class WelcomeController < ApplicationController
  def home
    if logged_in?
      redirect_to member_path(current_member)
    end
  end
end
