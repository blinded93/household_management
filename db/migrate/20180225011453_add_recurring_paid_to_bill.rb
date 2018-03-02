class AddRecurringPaidToBill < ActiveRecord::Migration
  def change
    add_column :bills, :recurring, :boolean
    add_column :bills, :paid, :boolean, default: :false
  end
end
