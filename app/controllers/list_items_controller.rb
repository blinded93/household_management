class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:update, :destroy]

  def create
    @list_item = ListItem.new(list_item_params)
    respond_to do |format|
      if @list_item.save
        format.js { render 'shared/create',
                    locals:{obj:@list_item}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@list_item}
                  }
      end
    end
  end

  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.js { render 'shared/update',
                    locals:{obj:@list_item}
                  }
      else
        format.js { render 'shared/errors',
                    locals:{obj:@list_item}
                  }
      end
    end
  end

  def destroy
    @list_item.destroy
    redirect_to :back
  end

  private
    def set_list_item
      @list_item = ListItem.find_by(id:params[:id])
    end

    def list_item_params
      params.require(:list_item).permit(:quantity, :brand, :info, :list_id, item_attributes:[:name])
    end
end
