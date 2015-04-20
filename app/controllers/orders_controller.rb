class OrdersController < ApplicationController

  def index
    if current_user != nil
      @orders = Order.where(status: %w(OBO Ordered))
    else
      redirect_to root_path
    end

  end

  def new
    if current_user != nil
     @order = Order.new
     @request = Request.find(params[:id])
    else
      redirect_to root_path
    end

  end

  def edit

    if current_user != nil
      @order = Order.find(params[:id])
      redirect_to :controller => 'orders', :action => 'new', :id => @order.request.id
    else
      redirect_to root_path
    end

  end


  def create
    @order = Order.new(create_params)
    if @order.save
      @order.update_now(@order.request_id)
      redirect_to :controller => 'orders', :action => 'show', :id => @order.id
    else
      render :controller => 'orders', :action => 'new', :id => @order.request.id
    end

  end

  def show
    if current_user != nil
        @order = Order.find(params[:id])
    else
      redirect_to root_path
    end

  end

  private
  def create_params
      params.require(:order).permit(:lot_no, :order_no, :catalog_no, :manufacturer, :supplier, :ordered_date,
                                    :ordered_amount, :unit_price, :request_id)
  end

end
