class InviteesController < ApplicationController
  before_action :set_invitee, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_logged_in
  before_action :correct_parent

  def login
    household = Household.find_by(id:params[:household_id])
    binding.pry
    render layout:false
  end

  def verify
    @invitee = Invitee.find_by(email: params[:email])
    if @invitee && @invitee.authenticate(params[:password])
      redirect_to [@invitee.household, :member, :new]
    else
      render :login
    end
  end

  def show
    @member = Member.new(first_name:params[:name], email:params[:email])
  end

  def new
    @invitee = Invitee.new
  end

  def create
    @invitee = current_household.invitees.build(invitee_params)
    @invitee.set_password
    binding.pry
    if @invitee.valid?
      @invitee.save
      MemberMailer.invite(current_member, @invitee).deliver_now
      redirect_to household_members_path(current_household)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @invitee.update(invitee_params)
      MemberMailer.invite(current_member, @invitee).deliver_now
      redirect_to household_members_path(@invitee.household)
    else
      render :edit
    end
  end

  def destroy
    @invitee.destroy
    redirect_to household_members_path(@invitee.household)
  end

  private
  def set_invitee
    @invitee = Invitee.find_by(params[:id])
  end

  def invitee_params
    params.require(:invitee).permit(:name, :email, :password, :household_id)
  end
end
