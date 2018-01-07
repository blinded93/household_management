class MembersController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new]
  before_action :set_member, only: [:show, :update, :destroy]

  def show
    @chores = @member.chores
    @message = Message.new
    @list_item = ListItem.new
    @item = @list_item.build_item
    @items = Item.all.pluck(:name)
    session[:admin] = false
  end

  def new
    @member = Member.new
    render layout:false
  end

  def create
    @member = Member.new(member_params)
    current_household.members << @member if current_household
    respond_to do |format|
      if @member.save
        format.js { render 'shared/create',
                    locals:{obj:@member}
                  }
      else
        format.js { render "shared/errors",
                    locals:{obj:@member}
                  }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.js { render 'shared/update',
                    locals:{obj:@member}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@member}
                  }
      end
    end
  end

  def destroy
    @member.destroy
    redirect_to [current_household, :control]
  end

  private
    def set_member
      @member ||= Member.find_by(id: params[:id])
    end

    def member_params
      params.require(:member).permit(:first_name, :last_name, :family_title, :monthly_income, :head_of_household, :email, :password)
    end
end
