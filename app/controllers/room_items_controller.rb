class RoomItemsController < ApplicationController
  before_action :set_room_item, only: [:inventory_request, :update, :destroy]

  def create
    @room_item = RoomItem.new(room_item_params)
    respond_to do |format|
      if @room_item.save
        format.js { render 'shared/create',
                    locals:{obj:@room_item}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@room_item}
                  }
      end
    end
  end

  def update
    if room_item_params[:stock].to_i > @room_item.stock
      @room_item.request = false
    end
    respond_to do |format|
      if @room_item.update(room_item_params)
        format.js { render 'shared/update',
                    locals:{obj:@room_item}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@room_item}
                  }
      end
    end
  end

  def inventory_request
    locals = {room_item:@room_item,
              a:params[:a]
              }
    if locals[:a] == "request"
      @room_item.request = true
      @room_item.save
    else
      @room_item.request = false
      @room_item.save
    end
    respond_to do |format|
        format.js { render 'request',
                    locals:locals
                  }
    end
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
      params.require(:room_item).permit(:a, :stock, :room_id, :threshold, item_attributes:[:name])
    end
end
