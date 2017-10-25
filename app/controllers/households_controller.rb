class HouseholdsController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new, :create]
  before_action :set_household, only: [:control, :settings, :edit, :update, :destroy]
  before_action :correct_parent, only: [:control]

  def control
    @chores = Chore.for(current_household)
    @chore = Chore.new
    @edit_chore = Chore.find_by(id: params[:id]) || Chore.first
    session[:menu_partial] = "layouts/household_menu"
  end

  def new
    @household = Household.new
    @member = @household.members.build
  end

  def create
    @household = Household.new(household_params)
    if @household.valid?
      @household.save
      member = @household.members.first
      session[:member_id] = member.id
      redirect_to household_control_path(@household)
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
      @household ||= current_household
    end

    def household_params
      params.require(:household).permit(:name, :address1, :address2, :city, :state, :zip_code, members_attributes: [:first_name, :last_name, :family_title, :monthly_income, :email, :password, :head_of_household])
    end
end
