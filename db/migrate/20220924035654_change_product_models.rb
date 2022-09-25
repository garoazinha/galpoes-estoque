class ChangeProductModels < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_models, :length, :depth
  end
end
