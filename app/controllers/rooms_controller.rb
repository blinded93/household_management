class RoomsController < ApplicationController
  before_action :set_room, only:[:update, :destroy]
  before_action :redirect_unless_logged_in

  def create
    @room = current_household.rooms.build(room_params)
    respond_to do |format|
      if @room.save
        format.js { render 'shared/create',
                    locals:{obj:@room}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@room}
                  }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.js { render 'shared/update',
                    locals:{obj:@room}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@room}
                  }
      end
    end
  end

  def destroy
    if @room
      @room.destroy
    end
    redirect_helper
  end

  private
    def set_room
      @room = Room.find_by(id:params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
