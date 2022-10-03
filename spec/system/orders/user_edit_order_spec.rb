require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    #Arrange
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    second_user = User.create!(name:'Pedro', email: 'pedro@pedro.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)

    #Act
    visit edit_order_path(order.id)
    
    #Assert
    expect(current_path).to eq(new_user_session_path)
    
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    second_user = User.create!(name:'Pedro', email: 'pedro@pedro.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    other_supplier = Supplier.create!(corp_name:'Lannister Brasil LTDA', brand_name: 'Lannister',
                                  registration_id: '91827447385482', city: 'Rio de Janeiro',
                                  state: 'RJ', full_address: 'Avenida Castelão. 423',
                                  email: 'ouv@lannister.com', phone: '2637920382')
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)

    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data prevista para entrega', with: '30/12/2022'
    select 'Lannister Brasil LTDA - CNPJ: 91.827.447/3854-82', from: 'Fornecedor'
    click_on 'Gravar'

    #Assert
    expect(page).to have_content('Pedido atualizado com sucesso')
    expect(page).to have_content('Galpão destino: GRU - Aeroporto SP')
    expect(page).to have_content('Fornecedor: Lannister Brasil LTDA - CNPJ: 91.827.447/3854-82')
    expect(page).to have_content('Data prevista para entrega: 30/12/2022')
  end

  it 'caso seja o responsável' do
    #Arrange
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    second_user = User.create!(name:'Pedro', email: 'pedro@pedro.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                  area: 100_000, useful_area: 80_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                  description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)

    #Act
    login_as(second_user)
    visit edit_order_path(order.id)
    
    #Assert
    expect(current_path).to eq root_path
    
  end
end