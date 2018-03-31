class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:edit, :update, :destroy]

  def new
    @list_item = ListItem.new
    @item = @list_item.build_item
    @items = Item.all.pluck(:name)
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@list_item}
      }
    end
  end

  def create
    @list_item = ListItem.new(list_item_params)
    respond_to do |format|
      if @list_item.save
        format.js
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@list_item}
        }
      end
    end
  end

  def edit
    @items = Item.all.pluck(:name)
    respond_to do |format|
      format.js {
        render 'shared/new_edit',
        locals:{obj:@list_item}
      }
    end
  end

  def update
    @old_scopes = @list_item.scopes.dup
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.js
      else
        format.js {
          render 'shared/errors',
          locals:{obj:@list_item}
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      @list_item.delete
      format.js {
        render 'shared/delete',
        locals:{obj:@list_item}
      }
    end
  end

  def reload
    if admin?
      @lists = List.for(current_household)
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def set_list_item
      @list_item = ListItem.find_by(id:params[:id])
    end

    def list_item_params
      params.require(:list_item).permit(:quantity, :brand, :info, :list_id, item_attributes:[:name])
    end
end
