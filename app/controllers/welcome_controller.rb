class WelcomeController < ApplicationController
  def home
    if logged_in?
      redirect_to household_member_path(current_household, current_member)
    end
  end
end
