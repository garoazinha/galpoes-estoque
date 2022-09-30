require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'valid?' do
    it 'falso se não tiver código' do
      #Arrange
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      order = Order.new(user: user, warehouse: warehouse,
                        supplier: supplier, estimated_delivery_date: '2022-12-31')
      #Act
      result = order.valid?
      #Assert
      expect(result).to be_truthy
    end
  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      #Arrange
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      order = Order.new(user: user, warehouse: warehouse,
                        supplier: supplier, estimated_delivery_date: '2022-12-31')
      #Act
      order.save! 
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      #Arrange
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      first_order = Order.create!(user: user, warehouse: warehouse,
                                  supplier: supplier, estimated_delivery_date: '2022-11-30')
      second_order = Order.new(user: user, warehouse: warehouse,
                                  supplier: supplier, estimated_delivery_date: '2022-11-30')
      #Act
      second_order.save! 

      #Assert
      expect(second_order.code).not_to eq first_order.code
      
    end
    
  end
end
