class RoomsController < ApplicationController
  before_action :set_room, only:[:update, :destroy]
  before_action :redirect_unless_logged_in

  def create
    @room = current_household.rooms.build(room_params)
    respond_to do |format|
      if @room.save
        format.json { head :no_content }
        format.js
      else
        format.js
      end
    end
  end

  def update
    if @room.update(room_params)
      redirect_helper
    else
      redirect_helper
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

    def redirect_helper
      redirect_to [current_household, :control, tab:'household', scope:'rooms']
    end
end
