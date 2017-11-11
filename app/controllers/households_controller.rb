class HouseholdsController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new, :create]
  before_action :set_household, only: [:control, :settings, :edit, :update, :destroy]
  before_action :correct_parent, only: [:control]

  def control
    @bills = current_household.bills
    @bill = Bill.new
    @bill_scopes = @bills.scopes
    @edit_bill = @bills.find_by(id: params[:id])
    @chores = Chore.for(current_household)
    @chore = Chore.new
    @chore_scopes = @chores.scopes
    @edit_chore = @chores.find_by(id: params[:id])
    @lists = List.for(current_household)
    @members = current_household.members
    @member = Member.new
    @invitees = current_household.invitees
    @invitee = Invitee.new
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = @bills.group_by(&:due_date).merge(@chores.group_by(&:due_date))
    session[:menu_partial] = "household"
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
