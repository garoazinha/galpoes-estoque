require 'rails_helper'

describe 'usuário vê o estoque' do
  it 'na tela de galpão' do
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                              registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                              full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                              phone: '3290906463')
    
    first_product = ProductModel.create!(name: 'Produto A', sku: 'PRODA-WAYSTAR-PA1234', weight: 100, 
      width:100, height: 80, depth: 20, supplier: supplier)
    second_product = ProductModel.create!(name: 'Produto B', sku: 'PRODB-WAYSTAR-PB1234', weight: 100, 
      width:110, height: 80, depth: 20, supplier: supplier)
    third_product = ProductModel.create!(name: 'Produto C', sku: 'PRODC-WAYSTAR-PC1234', weight: 100, 
      width:110, height: 80, depth: 20, supplier: supplier)
    order=Order.create!(user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 4.days.from_now)
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: first_product) }
    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: second_product) }

    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content("Itens em estoque")
    expect(page).to have_content("3 x PRODB-WAYSTAR-PB1234")
    expect(page).to have_content("2 x PRODA-WAYSTAR-PA1234")
    expect(page).not_to have_content("PRODC-WAYSTAR-PC1234")
  end

  it 'e dá baixa a um item do estoque' do
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                              registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                              full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                              phone: '3290906463')
    
    first_product = ProductModel.create!(name: 'Produto A', sku: 'PRODA-WAYSTAR-PA1234', weight: 100, 
      width:100, height: 80, depth: 20, supplier: supplier)
    
    order=Order.create!(user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 4.days.from_now)
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: first_product) }
    
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'PRODA-WAYSTAR-PA1234', from: "Item para saída"
    fill_in 'Destinatário', with: 'Maria Silva'
    fill_in 'Endereço destino', with: 'Rua das Grevíleas, 99, Maringá - PR'
    click_on 'Confirmar'

    expect(current_path).to eq (warehouse_path(warehouse.id))
    expect(page).to have_content('Item retirado com sucesso')
    expect(page).to have_content('1 x PRODA-WAYSTAR-PA1234')
    
  end

  it 'e ao dar baixa, não é possível dar baixa novamente' do
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                              registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                              full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                              phone: '3290906463')
    
    first_product = ProductModel.create!(name: 'Produto A', sku: 'PRODA-WAYSTAR-PA1234', weight: 100, 
      width:100, height: 80, depth: 20, supplier: supplier)
    
    order=Order.create!(user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 4.days.from_now)
    sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: first_product) 
    spd = sp.create_stock_product_destination!(recipient: "Homie Bro",
                                               address: 'Rua dos Amigos, 404, Maringá - PR')

    
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    
    within('div.stock_destination') do
      expect(page).not_to have_content('PRODA-WAYSTAR-PA1234')
    end

  end
end