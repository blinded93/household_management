class RoomItemsController < ApplicationController
  before_action :set_room_item, only: [:inventory_request, :edit, :update, :destroy]

  def new
    @room_item = RoomItem.new
    @item = @room_item.build_item
    @items = Item.all.pluck(:name)
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@room_item}
      }
    end
  end

  def create
    @room_item = RoomItem.new(room_item_params)
    respond_to do |format|
      if @room_item.save
        format.js
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@room_item}
        }
      end
    end
  end

  def edit
    @items = Item.all.pluck(:name)
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@room_item}
      }
    end
  end

  def update
    @old_room = current_household.rooms.find(@room_item.room_id)
    @old_scopes = @room_item.scopes.dup
    if room_item_params[:stock].to_i > @room_item.stock
      @room_item.request = false
    end
    respond_to do |format|
      if @room_item.update(room_item_params)
        format.js
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@room_item}
        }
      end
    end
  end

  def inventory_request
    locals = { a:params[:a] }
    if locals[:a] == "request"
      @room_item.toggle!(:request)
    elsif locals[:a] == "undo"
      @room_item.request = false
      @room_item.save
    end
    respond_to do |format|
        format.js {
          render 'request',
          locals:locals
        }
    end
  end

  def destroy
    respond_to do |format|
      @room_item.delete
      format.js {
        render 'shared/delete',
        locals:{obj:@room_item}
      }
    end
  end

  def reload
    @rooms = current_household.rooms.unowned
    respond_to do |format|
      format.js
    end
  end

  private
    def set_room_item
      @room_item = RoomItem.find_by(id:params[:id])
    end

    def room_item_params
      params.require(:room_item).permit(:a, :stock, :room_id, :threshold, item_attributes:[:name, :id])
    end
end
