class OrdersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    if current_user != nil
      @orders = Order.where(status: %w(OBO Ordered Delivered))
    else
      redirect_to root_path
    end

  end

  def new
    if current_user != nil
     @order = Order.new
    else
      redirect_to root_path
    end
  end

  def requests_for_supplier
    @requests = Request.where(supplier: params[:req][:supplier])
    render 'orders/new'
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
    puts(create_params[:order_no])
    puts(create_params[:supplier])
    puts(Date.parse(create_params[:ordered_date]))

    @order = Order.new(order_no: create_params[:order_no], supplier:create_params[:supplier],
          ordered_date: Date.parse(create_params[:ordered_date]))
    if @order.save
       @order.update_now(create_params)
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
    if current_user != nil
        @order = Order.find(params[:id])
    else
      redirect_to root_path
    end

  end

  private
  def create_params
      params.require(:order).permit!
  end

end
