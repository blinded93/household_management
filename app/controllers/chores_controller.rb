class ChoresController < ApplicationController
  before_action :set_chores, only:[:show, :destroy]
  before_action :set_chore, only:[:show, :edit, :update, :complete]
  before_action :redirect_unless_logged_in

  def create
    @chores = Chore.for(current_household)
    @chore = Chore.new(chore_params)
    respond_to do |format|
      if @chore.save
        format.js { render 'shared/create',
                    locals:locals
                  }
      else
        format.js { render 'shared/errors',
                    locals:locals
                  }
      end
    end
  end

  def update
    respond_to do |format|
      if @chore.update(chore_params)
        format.json { head :no_content }
        format.js { render 'shared/update',
                    locals:{obj:@chore}
                  }
      else
        format.js { render "shared/errors",
                    locals:{obj:@chore}
                  }
      end
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
    respond_to do |format|
      format.js { render 'complete',
                  locals:{chore_id:@chore.id}
                }
    end
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
