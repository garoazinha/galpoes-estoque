class Warehouse < ApplicationRecord
    validates :name, :city, :code, :area, :state, :useful_area, :description, :cep, presence: true
end
