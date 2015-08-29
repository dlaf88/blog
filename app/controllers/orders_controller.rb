class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
    
  end
 
  def new
   
    session[:order_params]||= {}
    @order = Order.new(session[:order_params]) 
    @order.current_step = session[:order_step]
    
  end
  
  def create
   
    session[:order_params].deep_merge!(params[:order]) if params[:order]
    params[:order]=session[:order_params]
    @order = Order.new(order_params)
    @order.current_step = session[:order_step]
    if params[:back_button]
      @order.previous_step
    elsif @order.last_step?
      @order.save 
    else 
      @order.next_step
    end 
    session[:order_step] = @order.current_step
   if @order.new_record?
    render "new"
  else
    session[:order_step] = session[:order_params] = nil
    flash[:notice] = "Order saved!"
    redirect_to @order
  end
    
      
  
  end
  
 


  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:shipping_name, :billing_name)
    end
end
