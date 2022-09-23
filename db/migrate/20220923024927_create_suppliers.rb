class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corp_name
      t.string :brand_name
      t.string :registration_id
      t.string :city
      t.string :state
      t.string :full_address
      t.string :email

      t.timestamps
    end
  end
end
