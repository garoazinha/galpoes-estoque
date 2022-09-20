class Warehouse < ApplicationRecord
    
    validates :name, :city, :code, :area, :state, :useful_area, :description, :cep, :address, presence: true
    validates :code, uniqueness:true
   
    validates :cep, format: { with: /\A[0-9]{5}-[0-9]{3}\z/, message: 'em formato errado (00000-000)' }
end
