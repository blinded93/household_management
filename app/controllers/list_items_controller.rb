class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:update, :destroy]

  def create
    list_item = ListItem.find_or_create(list_item_params)
    redirect_to [current_member, tab:'requests']
  end

  def update
    @list_item.update(list_item_params)
    redirect_to [current_member, tab:'requests']
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
