class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_logged_in, only: [:show, :edit, :update, :destroy]

  def index
    @members = current_household.members
    @member = Member.new
  end

  def show
    session[:menu_partial] = "layouts/member_menu"
    @chores = @member.chores
    @message = Message.new
  end

  def new
    @member = Member.new
  end

  def create
    raise params.inspect
    @member = Member.create(member_params)
    if @member.valid?
      @member.save
      session[:member_id] = @member.id
      session[:menu_partial] = "layouts/member_menu"
      if @member.household.present?
        redirect_to member_path(@member), notice: "Account successfully create."
      else
        redirect_to new_household_path, notice: "Please create a household to continue."
      end
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @member.update(member_params)
      redirect_to household_member_path(current_household, @member)
    else
      render :edit
    end
  end

  def destroy

  end

  private
    def set_member
      @member = Member.find_by(id: params[:id])
    end

    def member_params
      params.require(:member).permit(:first_name, :last_name, :family_title, :monthly_income, :head_of_household, :email, :password)
    end
end
