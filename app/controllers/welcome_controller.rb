class WelcomeController < ApplicationController
  def home
    if logged_in?
      redirect_to member_path(current_member)
    end
    @household = Household.new
    @member = @household.members.build
  end
end
