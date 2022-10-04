require 'rails_helper'


describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'vê seus pedidos e não vê outros pedidos' do
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
    first_order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now,
                                status: 'pending')
    
    second_order = Order.create!(user: second_user, warehouse: warehouse,
                                  supplier: supplier, estimated_delivery_date: 4.days.from_now,
                                  status: 'delivered')

    third_order = Order.create!(user: user, warehouse: warehouse,
                              supplier: supplier, estimated_delivery_date: 4.days.from_now,
                              status: 'canceled')
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'

    #Assert
    expect(page).to have_content(first_order.code)
    expect(page).to have_content('Pendente')
    expect(page).not_to have_content(second_order.code)
    expect(page).not_to have_content('Entregue')
    expect(page).to have_content(third_order.code)
    expect(page).to have_content('Cancelado')
    


  end

  it 'e visita um pedido' do
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
    first_order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)
    #aAct
    login_as(user)
    visit root_path 
    click_on 'Meus Pedidos'
    click_on first_order.code
    #Assert
    expect(page).to have_content('Detalhes do Pedido')
    expect(page).to have_content(first_order.code)

    expect(page).to have_content("Galpão destino: GRU - Aeroporto SP")
    expect(page).to have_content("Fornecedor: Waystar Roy Group Inc")
    formatted_date = I18n.localize(4.days.from_now.to_date)
    expect(page).to have_content("Data prevista para entrega: #{formatted_date}")
    
  end

  it 'e não visita pedidos de outro usuário' do
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
    first_order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now)
    #Act
    login_as(second_user)
    visit order_path(first_order.id)
    #Assert
    expect(current_path).not_to eq(order_path(first_order.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não possui acesso a esse pedido')
  end
end