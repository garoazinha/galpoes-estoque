class Api::V1::WarehousesController < Api::V1::ApiController
  
  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
  end

  def index
    warehouses = Warehouse.all.order(:name)
    render status: 200, json: warehouses
  end

  def create
    begin
      warehouse_params = params.require(:warehouse).permit(:name, :code, :area, :useful_area, :city,
                                                          :state, :address, :description, :cep)
      warehouse = Warehouse.new(warehouse_params)
      if warehouse.save
        render status: 201, json: warehouse.as_json(except:  [:created_at, :updated_at])
      else
        render status: 412, json: { errors: warehouse.errors.full_messages }
      end
    rescue
      render status: 500
    end
  end


end