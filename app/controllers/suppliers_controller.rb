class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end
  
  def new
    @supplier = Supplier.new
  end

  def create
    
    supplier_params = params.require(:supplier).permit(:corp_name, :brand_name,
                                                        :registration_id, :city, :state,
                                                        :full_address, :email, :phone)
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render :new
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    supplier_params = params.require(:supplier).permit(:corp_name, :brand_name,
                                                       :registration_id, :city, :state,
                                                       :full_address, :email, :phone)
    if @supplier.update(supplier_params)
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso'
    else 
      flash.now[:notice] = 'Fornecedor não pode ser atualizado'
      render :edit
    end



  end



end