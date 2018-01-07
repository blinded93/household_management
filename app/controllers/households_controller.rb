class HouseholdsController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new, :create]
  before_action :set_household, only: [:control, :update, :destroy]
  before_action :correct_parent, only: [:control]

  def control
    @bill = Bill.new
    @chores = Chore.for(current_household)
    @chore = Chore.new
    @lists = List.for(current_household)
    @member = Member.new
    @room = Room.new
    @room_item = RoomItem.new
    @item = @room_item.build_item
    @items = Item.all.pluck(:name)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = current_household.bills.group_by(&:due_date).merge(@chores.group_by(&:due_date))
    session[:admin] = true
  end

  def create
    @household = Household.new(household_params)
    member = @household.members[0]
    respond_to do |format|
      if @household.save
        session[:member_id] = @household.members[0].id
        format.js
      else
        format.js { render 'errors',
                    locals:{ household:@household,
                             member:member
                            }
                   }
      end
    end
  end

  def update
    respond_to do |format|
      if @household.update(household_params)
        format.js { render 'update',
                    locals:{ obj:@household
                            }
                   }
      else
        format.js { render 'shared/errors',
                    locals: { obj:@household
                            }
                   }
      end
    end
  end

  def destroy

  end

  private
    def set_household
      @household ||= current_household
    end

    def household_params
      params.require(:household).permit(:name, :address1, :address2, :city, :state, :zip_code, :password, members_attributes: [:first_name, :last_name, :family_title, :monthly_income, :email, :password, :head_of_household])
    end
end
