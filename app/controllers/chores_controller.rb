class ChoresController < ApplicationController
  before_action :set_chores, only:[:show, :destroy]
  before_action :set_chore, only:[:show, :edit, :update, :complete]
  before_action :redirect_unless_logged_in
  before_action :correct_parent, except: [:index, :show, :complete, :destroy]

  def create
    @chore = Chore.new(chore_params)
    respond_to do |format|
      if @chore.save
        format.json { head :no_content }
        format.js
      else
        format.js
      end
    end
  end

  def update
    if @chore.update(chore_params)
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    if chore = Chore.find_by(id:params[:id])
      chore.destroy
    else
      @chores.completed.destroy_all
    end
    redirect_to :back
  end

  def complete
    @chore.toggle!(:completed)
    redirect_to :back
  end

  private
  def set_chores
    if params[:scope]
      @chores = current_member.chores.send(params[:scope])
    else
      @chores = current_member.chores
    end
  end

  def set_chore
    @chore = Chore.find_by(id: params[:id])
  end

  def chore_params
    params.require(:chore).permit(:task, :due_date, :member_id)
  end
end
