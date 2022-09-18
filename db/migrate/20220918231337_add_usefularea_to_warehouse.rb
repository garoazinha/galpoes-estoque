class AddUsefulareaToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :useful_area, :integer
  end
end
