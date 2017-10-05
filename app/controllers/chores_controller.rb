class ChoresController < ApplicationController
  def index
    @chores = Chore.send(params[:scope]).for(current_member)
  end
end
