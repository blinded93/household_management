class MembersController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new]
  before_action :set_member, only: [:show, :edit, :update, :destroy]

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
      format.js {
        render 'shared/new_edit',
        locals:{obj:@member}
      }
    end
  end

  def create
    @member = Member.new(member_params)
    current_household.members << @member if current_household
    respond_to do |format|
      if @member.save
        format.js {
          render 'create',
          locals:{member:@member}
        }
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
        format.js {
          render 'update',
          locals:{member:@member}
        }
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

  private
    def set_member
      @member ||= Member.find_by(id: params[:id])
    end

    def member_params
      params.require(:member).permit(:first_name, :last_name, :family_title, :monthly_income, :head_of_household, :email, :password)
    end
end
