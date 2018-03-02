class HouseholdsController < ApplicationController
  before_action :redirect_unless_logged_in, except: [:new, :create]
  before_action :set_household, only: [:control, :edit, :update, :destroy]

  def control
    @chores = Chore.for(current_household)
    @chores_by_date = @chores.group_by(&:due_date)
    @lists = List.for(current_household)
    @items = Item.all.pluck(:name)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @bills = current_household.bills.group_by(&:due_date)
    @events = @bills.merge(@chores_by_date)
    session[:admin] = true
  end

  def join
    respond_to do |format|
      format.js
    end
  end

  def join_household
    household = Household.find_by(id:params[:household_id])
    respond_to do |format|
      if household && household.authenticate(params[:household_passphrase])
        current_member.join_household(household)
        format.js {
          render 'create'
        }
      else
        format.js {
          render 'join_errors'
        }
      end
    end
  end

  def new
    @household = Household.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @household = Household.new(household_params)
    respond_to do |format|
      if @household.save
        current_member.join_household(@household)
        format.js
      else
        format.js {
          render 'errors',
          locals:{
            household:@household,
          }
        }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@household}
      }
    end
  end

  def update
    respond_to do |format|
      if @household.update(household_params)
        format.js {
          render 'update',
          locals:{household:@household}
        }
      else
        format.js {
          render 'shared/errors',
          locals: { obj:@household}
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
