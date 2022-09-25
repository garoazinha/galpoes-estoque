class ProductModelsController < ApplicationController
  def show
    @product_model = ProductModel.find(params[:id])
  end
  def index
    @product_models = ProductModel.all
  end
  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    
    product_model_params = params.require(:product_model).permit(:name, :sku, :width, :height,
                                                                :depth, :weight, :supplier_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save()
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
    else
      @suppliers= Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar modelo de produto'
      render :new
    end
  end
end