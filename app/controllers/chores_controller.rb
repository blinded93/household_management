class ChoresController < ApplicationController
  before_action :set_chore, only:[:edit, :update, :destroy, :complete]
  before_action :redirect_unless_logged_in

  def new
    @chore = Chore.new
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@chore}
      }
    end
  end

  def create
    @chore = Chore.new(chore_params)
    respond_to do |format|
      if @chore.save
        format.js {
          render 'create',
          locals:{chore:@chore}
        }
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@chore}
        }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@chore}
      }
    end
  end

  def update
    @old_scopes = @chore.scopes.dup
    respond_to do |format|
      if @chore.update(chore_params)
        format.js {
          render 'update',
          locals:{chore:@chore}
        }
      else
        format.js {
          render "shared/errors",
          locals:{obj:@chore}
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      locals = {objs:Chore.for(current_household)}
      if @chore
        locals[:obj] = @chore
        @chore.destroy
        format.js {
          render 'shared/delete',
          locals:locals
        }
      else
        @chores = locals[:chores].completed
        locals[:chore_ids] = @chores.pluck(:id)
        @chores.delete_all
        format.js {
          render 'delete',
          locals:locals
        }
      end
    end
  end

  def complete
    @old_scopes = @chore.scopes.dup
    @chore.toggle!(:completed)
    respond_to do |format|
      format.js {
        render 'complete',
        locals:{chore:@chore}
      }
    end
  end

  def reload
    if current_url.include?("household")
      @chores = Chore.for(current_household)
    else
      @chores = current_member.chores
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def set_chore
      @chore = Chore.find_by(id: params[:id])
    end

    def chore_params
      params.require(:chore).permit(:task, :due_date, :member_id)
    end
end
