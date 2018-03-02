class WelcomeController < ApplicationController
  def home
    if logged_in?
      if !current_household
        redirect_to join_complete_path
      else
        redirect_to member_path(current_member)
      end
    end
    @household = Household.new
    @member = @household.members.build
  end

  def complete
    if current_member
      if current_household
        redirect_to member_path(current_member)
      end
    else
      redirect_to root_path
    end
    @household = Household.new
  end
end
