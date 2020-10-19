class LikesController < ApplicationController

  def index
    Like.create(favorite: 1, user_id: current_user.id, item_id: params[:item_id])
    redirect_to item_path(params[:item_id])
  end

  def destroy
    @like = current_user.likes.find_by(item_id: params[:item_id])
    @like.destroy
    redirect_to item_path(params[:item_id])
  end

end
