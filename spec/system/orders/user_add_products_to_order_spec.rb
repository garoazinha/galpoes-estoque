require 'rails_helper'

describe 'Usuário adiciona produtos ao pedido' do
  it 'com sucesso' do
    #Arrange
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
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code 
    click_on 'Adicionar Item'
    select 'Produto A', from: "Produto"
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    #Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Item adicionado com sucesso')
    expect(page).to have_content('8 x Produto A')
    
  end

  it 'e não vê produtos de outros fornecedor' do
    #Arrange
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    
    other_supplier = Supplier.create!(corp_name: 'Devintex Cosméticos Ltda', brand_name: 'Devintex',
                                      registration_id: '01773518000120', city: 'Jandira', state: 'SP',
                                      full_address: 'Rua Pereira, 300', email:'contato@devintex.com',
                                      phone: '3290906477')
    first_product = ProductModel.create!(name: 'Produto A', sku: 'PRODA-WAYSTAR-PA1234', weight: 100, 
                                        width:100, height: 80, depth: 20, supplier: supplier)
    second_product = ProductModel.create!(name: 'Produto B', sku: 'PRODB-WAYSTAR-PB1234', weight: 100, 
                                        width:110, height: 80, depth: 20, supplier: other_supplier)
    third_product = ProductModel.create!(name: 'Produto C', sku: 'PRODC-WAYSTAR-PC1234', weight: 100, 
                                        width:110, height: 80, depth: 20, supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse,
                          supplier: supplier, estimated_delivery_date: 4.days.from_now)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code 
    click_on 'Adicionar Item'

    #Assert
    expect(page).to have_content('Produto A')
    expect(page).not_to have_content('Produto B')
    expect(page).to have_content('Produto C')


  end
end