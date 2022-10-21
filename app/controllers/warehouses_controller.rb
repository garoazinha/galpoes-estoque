class WarehousesController < ApplicationController
    before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
    def show
        @stock = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count()
        @product_model = @warehouse.stock_products.where.missing(:stock_product_destination).extract_associated(:product_model).uniq
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        warehouse_params[:cep].gsub!('-','')
        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save()
            
            
            redirect_to root_path, notice: "Galpão cadastrado com sucesso"
        else
            flash.now[:notice] = 'Galpão não cadastrado'
            render :new
        end
    end

    def edit 
    end

    def update
        warehouse_params[:cep].gsub!('-','')
        if @warehouse.update(warehouse_params)
            redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
        else
            flash.now[:notice] = "Galpão não pode ser atualizado"
            render :edit
        end

    end

    def destroy
    
        @warehouse.destroy
        redirect_to root_path, notice: 'Galpão removido com sucesso'

    end

    private
    def set_warehouse
        @warehouse = Warehouse.find(params[:id])
    end
    
    def warehouse_params
        params.require(:warehouse).permit(:name, :code, :city, :state,
                                          :address, :cep, :area,
                                          :useful_area, :description)
    end
end