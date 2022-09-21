class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end
    def new
        @warehouse = Warehouse.new
        
    end
    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :state,
                                                            :address, :cep, :area,
                                                            :useful_area, :description)
        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save()
            
            
            redirect_to root_path, notice: "Galpão cadastrado com sucesso"
        else
            flash.now[:notice] = 'Galpão não cadastrado'
            render :new
        end
    end
    def edit
        @warehouse = Warehouse.find(params[:id])
        
    end
    def update
        @warehouse = Warehouse.find(params[:id])
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :state,
                                                             :address, :cep, :area,
                                                             :useful_area, :description)
        if @warehouse.update(warehouse_params)
            redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
        else
            flash.now[:notice] = "Galpão não pode ser atualizado"
            render :edit
        end

    end
end