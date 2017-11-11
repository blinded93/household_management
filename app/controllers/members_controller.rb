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
    @chores = @member.chores
    @message = Message.new
    @list_item = ListItem.new
    @item = @list_item.build_item
    @items = Item.all.pluck(:name)
    session[:menu_partial] = "member"
  end

  def new
    @member = Member.new
    render layout:false
  end

  def create
    @member = current_household.members.build(member_params)
    if @member.valid?
      @member.save
      redirect_to :back
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
    @member.destroy
    redirect_to [current_household, :control]
  end

  private
    def set_member
      @member = Member.find_by(id: params[:id])
    end

    def member_params
      params.require(:member).permit(:first_name, :last_name, :family_title, :monthly_income, :head_of_household, :email, :password)
    end
end
