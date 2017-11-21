class RoomItemsController < ApplicationController
  before_action :set_room_item, only: [:inventory_request, :update, :destroy]

  def create
    room_item = RoomItem.find_or_create(room_item_params)
    redirect_to [current_household, :control, tab:'inventory']
  end

  def inventory_request
    @room_item.request = true
    @room_item.save
    redirect_to [current_member, tab:'inventory']
  end

  def update
    if room_item_params[:stock].to_i > @room_item.stock
      @room_item.request = false
    end
    @room_item.update(room_item_params)
    redirect_to [current_household, :control]
  end

  def destroy
    @room_item.destroy
    redirect_to :back
  end

  private
    def set_room_item
      @room_item = RoomItem.find_by(id:params[:id])
    end

    def room_item_params
      params.require(:room_item).permit(:stock, :room_id, :threshold, item_attributes:[:name])
    end
end
