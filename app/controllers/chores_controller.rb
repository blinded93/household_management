class ChoresController < ApplicationController
  before_action :set_chores, only:[:index]

  def index
  end

  def complete
    set_chores
    # byebug
    @chores.each do |chore|
      if params[:chore_ids].try(:include?, chore.id.to_s)
        chore.completed = true
        chore.save
      else
        chore.completed = false
        chore.save
      end
    end
    redirect_to :back
  end

  def update

  end

  private
  def set_chores
    @chores = Chore.send(params[:scope]).for(current_member)
  end
end
