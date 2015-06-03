class OrdersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @orders = Order.where(status: %w(OBO Ordered Delivered))
  end

  def new
   @order = Order.new
  end

  def requests_for_supplier
    @requests = Request.where(supplier: params[:req][:supplier])
    render 'orders/new'
  end

  def edit
      @order = Order.find(params[:id])
      @requests = Request.where(:order_id => @order.id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_no: order_params[:order_no], ordered_date: order_params[:ordered_date],
                     supplier: order_params[:supplier])
      @order.update_now(order_params)
      redirect_to :action => 'show', :controller => 'orders', :id => @order.id
    else
      redirect_to :action => 'edit', :controller => 'orders', :id => @order.id
    end
  end


  def create
    @order = Order.new(order_no: order_params[:order_no], supplier:order_params[:supplier],
          ordered_date: Date.parse(order_params[:ordered_date]))
    if @order.save
       @order.update_now(order_params)
      begin
        NoticeMailer.notify_new_order(@order).deliver
      rescue Exception => e
        logger.error("Message for the log file #{e.message}")
      end

      redirect_to :controller => 'orders', :action => 'show', :id => @order.id
    else
      render :controller => 'orders', :action => 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
      params.require(:order).permit!
  end

end
