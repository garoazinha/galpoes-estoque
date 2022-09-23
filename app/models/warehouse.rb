class Warehouse < ApplicationRecord
    
    validates :name, :city, :code, :area, :state, :useful_area, :description, :cep, :address, presence: true
    validates :code, :name, uniqueness:true
   
    validates :cep, format: { with: /\A[0-9]{8}\z/, message: 'em formato errado (00000-000)' }
end
