class BillsController < ApplicationController
  before_action :set_bill
  before_action :redirect_unless_logged_in
  before_action :correct_parent
end
