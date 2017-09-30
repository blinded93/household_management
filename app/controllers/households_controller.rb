class HouseholdsController < ApplicationController
  before_action :set_household, only: [:settings, :edit, :update, :destroy]
  before_action :redirect_unless_logged_in

  def settings

  end

  def show
  end

  def new
    @household = Household.new
  end

  def create
    @household = current_member.create_household(household_params)
    if @household.valid?
      @household.save
      redirect_to household_settings_path(current_household)
    else
      render :new
    end
  end

  def edit
  end

  def update

  end

  def destroy

  end

  private
    def set_household
      @household ||= current_member.household
    end

    def household_params
      params.require(:household).permit(:name, :address)
    end
end
