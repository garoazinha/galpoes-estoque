class WarehousesController < ApplicationController
    def show
        @warehouse = Warehouse.find(params[:id])
    end
    def new
        
    end
    def create
        warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :state,
                                                            :address, :cep, :area,
                                                            :useful_area, :description)
        w = Warehouse.new(warehouse_params)
        if w.valid?
            w.save()
            flash[:notice] = "Galpão cadastrado com sucesso"
            redirect_to root_path
        else
            flash[:alert] = 'Dados em falta'
            render :new
        end
    end
end