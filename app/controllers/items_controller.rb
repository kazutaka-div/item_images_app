class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      flash.now[:alert] = "出品に失敗しました"
      # binding.pry
      render :new 
      # redirect_to new_item_path
      # redirect_to new_item_path, alert: @item.errors.full_messages
    end
  end

  def edit
    @item = Item.find(params[:id])
    @item.images.build
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      redirect_to edit_item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def buy
    @item = Item.find(params[:id])
    @card = Card.get_card(current_user.card.customer_token) if current_user.card
  end

  def buyafter
    @item = Item.find(params[:id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      customer: customer_token, # 顧客、もしくはカードのトークン
      currency: 'jpy'  # 通貨の種類
    )
    redirect_to item_path(@item), notice: "商品を購入しました"
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :prefecture_id, images_attributes: [:src,:id,:_destroy]).merge(user_id: current_user.id)
  end
  
end
