class Warehouse < ApplicationRecord
    
    validates :name, :city, :code, :area, :state, :useful_area, :description, :cep, :address, presence: true
    validates :code, uniqueness:true
    validates :cep, length: { is: 9 }
    validates :cep, format: { with: /[0-9]{5}-[0-9]{3}/  }
end
