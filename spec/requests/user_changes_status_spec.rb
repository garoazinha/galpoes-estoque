require 'rails_helper'

describe 'Usuário muda status do pedido' do
  it 'e não é o dono' do
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
                                supplier: supplier, estimated_delivery_date: 4.days.from_now,
                                status: :pending)
    #Act
    login_as(second_user)
    post(delivered_order_path(order.id), params: { order: {status: :delivered} })

    #Assert
    expect(response).to redirect_to(root_path)

  end
end