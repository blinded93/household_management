class BillsController < ApplicationController
  before_action :set_bill, only: [:update, :destroy]
  before_action :redirect_unless_logged_in
  before_action :correct_parent

  def create
    @bill = current_household.bills.build(bill_params)
    respond_to do |format|
      if @bill.save
        format.js { render 'shared/create',
                    locals:{obj:@bill}
                  }
      else
        format.js { render "shared/errors",
                    locals:{obj:@bill}
                  }
      end
    end
  end

  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.js { render 'shared/update',
                    locals:{obj:@bill}
                  }
      else
        format.js { render "shared/errors",
                    locals:{obj:@bill}
                  }
      end
    end
  end

  def destroy
    @bill.destroy
    redirect_to :back
  end

  private
    def bill_params
      params.require(:bill).permit(:company, :utility, :amount, :due_date, :account_number)
    end

    def set_bill
      @bill = Bill.find_by(id: params[:id])
    end
end
