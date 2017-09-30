class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before action :redirect_unless_logged_in, only: [:show, :edit, :update, :destroy]
  def index
    @members = current_household.members
  end

  def show
  end

  def new
    @member = Member.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def set_member
      @member = Member.find_by(id: params[:id])
    end

    def member_params
      params.require(:member).permit(:email, :password)
    end
end
