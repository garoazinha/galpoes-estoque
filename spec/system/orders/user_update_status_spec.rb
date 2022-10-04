require 'rails_helper'

describe 'Usuário atualiza status' do
  it 'e pedido foi entregue' do
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
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now,
                                status: :pending )
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on "Marcar como ENTREGUE"
    #Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content("Situação do pedido: Entregue")
    expect(page).not_to have_button('Marcar como ENTREGUE')

  end

  it 'e pedido foi cancelado' do
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
    order = Order.create!(user: user, warehouse: warehouse,
                                supplier: supplier, estimated_delivery_date: 4.days.from_now,
                                status: :pending )
    #Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on "Marcar como CANCELADO"
    #Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content("Situação do pedido: Cancelado")
    expect(page).not_to have_button('Marcar como CANCELADO')
    
  end
end