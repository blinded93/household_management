class BillsController < ApplicationController
  before_action :set_bill, only: [:update, :destroy]
  before_action :redirect_unless_logged_in

  def new
    @bill = Bill.new
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@bill}
      }
    end
  end

  def create
    @bill = current_household.bills.build(bill_params)
    respond_to do |format|
      if @bill.save
        format.js {
          render 'create',
          locals:{bill:@bill}
        }
      else
        format.js {
          render "shared/errors",
          locals:{obj:@bill}
        }
      end
    end
  end

  def edit
    @bill = Bill.find_by(id: params[:id])
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@bill}
      }
    end
  end

  def update
    @old_scopes = @bill.scopes.dup
    respond_to do |format|
      if @bill.update(bill_params)
        format.js {
          render 'update',
          locals:{bill:@bill}
        }
      else
        format.js {
          render "shared/errors",
          locals:{obj:@bill}
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      locals = {objs:current_household.bills}
      locals[:obj] = @bill
      @bill.destroy
      format.js {
        render 'shared/delete',
        locals:locals
      }
    end
  end

  private
    def bill_params
      params.require(:bill).permit(:company, :utility, :amount, :due_date, :account_number)
    end

    def set_bill
      @bill = Bill.find_by(id: params[:id])
    end
end
