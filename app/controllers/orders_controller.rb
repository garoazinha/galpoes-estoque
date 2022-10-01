class OrdersController < ApplicationController
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash[:notice] = "Pedido não pode ser registrado"
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end