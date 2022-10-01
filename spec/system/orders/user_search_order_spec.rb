require 'rails_helper'

describe 'Usuário busca pedido' do 
  it 'a partir do menu' do
    #arrange
    user = User.create!(name:"Mari", email: "mari@mari.com", password: "password")
    #act
    login_as(user)
    visit root_path
    #assert
    within('header nav') do
      expect(page).to have_field("Buscar Pedido")
      expect(page).to have_button("Buscar")
    end
  end

  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_path
    #Assert
    within('header nav') do
      expect(page).not_to have_field("Buscar Pedido")
      expect(page).not_to have_button("Buscar")
    end
  end

  it 'e encontra um pedido' do
    #arrange
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
                         supplier: supplier, estimated_delivery_date: 4.days.from_now)
    #act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    #assert
    expect(page).to have_content("Resultados da Busca por: #{order.code}")
    expect(page).to have_content("1 pedido encontrado")
    expect(page).to have_content("Código: #{order.code}")
    expect(page).to have_content("Galpão destino: GRU - Aeroporto SP")
    expect(page).to have_content("Fornecedor: Waystar Roy Group Inc - CNPJ: 56.478.345/2184-39")

  end
end