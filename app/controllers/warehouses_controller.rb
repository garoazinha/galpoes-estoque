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
        w.save()
        redirect_to root_path
    end
end