class MembersController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new, :create]
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_complete, only: [:show]

  def show
    @chores = @member.chores
    @list_item = ListItem.new
    @item = @list_item.build_item
    @items = Item.all.pluck(:name)
    session[:admin] = false
  end

  def new
    @member = Member.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @member = Member.new(member_params)
    @household = Household.new
    household = Household.find_by(id:household_params[:household_id])
    if household && household.authenticate(household_params[:household_passphrase])
      @member.household = household
    end
    respond_to do |format|
      if @member.save
        session[:member_id] = @member.id
        format.js
      else
        format.js {
          render "shared/errors",
          locals:{obj:@member}
        }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@member}
      }
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.js
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@member}
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      @member.destroy
      format.js {
        render 'shared/delete',
        locals:{obj:@member}
      }
    end
  end

  def reload
    @members = current_household.members
    respond_to do |format|
      format.js
    end
  end

  private
    def set_member
      @member ||= Member.find_by(id: params[:id])
    end

    def redirect_unless_complete
      if !current_household || current_member.household_id == 0
        redirect_to join_complete_path
      end
    end

    def member_params
      params.require(:member).permit(:first_name, :last_name, :monthly_income, :head_of_household, :email, :password)
    end

    def household_params
      params.permit(:household_id, :household_passphrase)
    end
end
