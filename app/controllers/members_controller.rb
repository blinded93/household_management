class MembersController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new]
  before_action :set_member, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_parent, except: [:show]

  def index
    @members = current_household.members
    @member = Member.new
    @invitees = current_household.invitees
    @invitee = Invitee.new
  end

  def show
    session[:menu_partial] = "layouts/member_menu"
    @chores = @member.chores
    @message = Message.new
    @list_item = ListItem.new
    @item = @list_item.build_item
    @items = Item.all
  end

  def new
    @member = Member.new
    render layout:false
  end

  def create
    @member = current_household.members.build(member_params)
    if @member.valid?
      @member.save
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
      redirect_to household_members_path(current_household)
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
