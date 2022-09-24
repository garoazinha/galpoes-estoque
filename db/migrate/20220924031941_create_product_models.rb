class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.string :sku
      t.integer :width
      t.integer :length
      t.integer :height
      t.integer :weight
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
