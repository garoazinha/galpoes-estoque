require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
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
      product = ProductModel.new(name: 'Produto A', sku: 'PRODA-TESTEDEL-12345', weight: 100, width: 100,
                                 height: 20, depth: 12, supplier: supplier)
      order = Order.create!(user: user, warehouse: warehouse,
                            supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)

      #Act

      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      #Assert
      expect(sp.serial_number.length).to eq(20)
    end

    it 'e não é modificado' do
      #Arrange
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      warehouse_b = Warehouse.create!(name: 'Galpão RIO', code: 'RIO', city: 'Niterói', state: 'RJ',
                                    area: 100_000, useful_area: 80_000,
                                    address: 'Avenida do Jesus, 1080', cep: '17000000', 
                                    description: 'Galpão destinado para cargas marítimas')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      product = ProductModel.new(name: 'Produto A', sku: 'PRODA-TESTEDEL-12345', weight: 100, width: 100,
                                 height: 20, depth: 12, supplier: supplier)
      order = Order.create!(user: user, warehouse: warehouse,
                            supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = sp.serial_number
      #Act
      sp.update!(warehouse: warehouse_b)
      #Assert
      expect(sp.serial_number).to eq(original_serial_number)
      
      
    end
  end

  describe 'available?' do
    it 'true se não tiver destino' do
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      warehouse_b = Warehouse.create!(name: 'Galpão RIO', code: 'RIO', city: 'Niterói', state: 'RJ',
                                    area: 100_000, useful_area: 80_000,
                                    address: 'Avenida do Jesus, 1080', cep: '17000000', 
                                    description: 'Galpão destinado para cargas marítimas')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      product = ProductModel.new(name: 'Produto A', sku: 'PRODA-TESTEDEL-12345', weight: 100, width: 100,
                                 height: 20, depth: 12, supplier: supplier)
      order = Order.create!(user: user, warehouse: warehouse,
                            supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      
      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(sp.available?).to be true
    end
    
    it 'false se tiver destino' do
      user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
      warehouse_b = Warehouse.create!(name: 'Galpão RIO', code: 'RIO', city: 'Niterói', state: 'RJ',
                                    area: 100_000, useful_area: 80_000,
                                    address: 'Avenida do Jesus, 1080', cep: '17000000', 
                                    description: 'Galpão destinado para cargas marítimas')
      supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                  registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                  full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                  phone: '3290906463')
      product = ProductModel.new(name: 'Produto A', sku: 'PRODA-TESTEDEL-12345', weight: 100, width: 100,
                                 height: 20, depth: 12, supplier: supplier)
      order = Order.create!(user: user, warehouse: warehouse,
                            supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      
      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      spd = sp.create_stock_product_destination!(recipient: "Homie Bro",
                                               address: 'Rua do Amigo, 404, Maringá - PR')

      expect(sp.available?).to be false

      
    end
  end
end
