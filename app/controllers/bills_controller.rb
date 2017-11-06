class BillsController < ApplicationController
  before_action :set_bill, only: [:update, :destroy]
  before_action :redirect_unless_logged_in
  before_action :correct_parent

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @bills = current_household.bills
  end

  def create
    @bill = current_household.bills.build(bill_params)
    if @bill.valid?
      @bill.save
    else
      render :new
    end
    redirect_to household_control_path(current_household)
  end

  def update
    if @bill.update(bill_params)
      redirect_to household_control_path(current_household)
    else
      render :edit
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
