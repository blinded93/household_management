class ChoresController < ApplicationController
  before_action :set_chores, only:[:show, :destroy]
  before_action :set_chore, only:[:show, :edit, :update, :complete]
  before_action :redirect_unless_logged_in
  before_action :correct_parent, except: [:index, :show, :complete]

  def index
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(chore_params)
    if @chore.valid?
      @chore.save
      redirect_to household_control_path(current_household)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chore.update(chore_params)
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @chores.completed.destroy_all
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
