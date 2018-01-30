class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :destroy]
  before_action :redirect_unless_logged_in

  def new
    @room = Room.new
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@room}
      }
    end
  end

  def create
    @room = current_household.rooms.build(room_params)
    respond_to do |format|
      if @room.save
        format.js {
          render 'create',
          locals:{room:@room}
        }
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@room}
        }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@room}
      }
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.js {
          render 'update',
          locals:{room:@room}
        }
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@room}
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      @room.destroy
      format.js {
        render 'shared/delete',
        locals:{obj:@room}
      }
    end
  end

  private
    def set_room
      @room = Room.find_by(id:params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
