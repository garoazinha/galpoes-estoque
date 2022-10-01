require 'rails_helper'

describe 'Usuário cadastra pedido' do
  it 'e deve estar autenticado' do
    #Arrange

    #Act
    visit root_path
    click_on 'Registrar Pedido'
    
    #Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso'do
    #Arrange
    user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    Warehouse.create(name: 'Galpão Rio', code: 'SDU' , city: 'Rio de Janeiro',
                    state: 'RJ', cep: '80000000', address: 'Rua do Malandro, 22',
                    area: 60_000, useful_area:50_000,
                    description:'Galpão principal do Rio de Janeiro')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                area: 100_000, useful_area: 80_000,
                                address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                description: 'Galpão destinado para cargas internacionais')
    Supplier.create!(corp_name:'Lannister Brasil LTDA', brand_name: 'Lannister',
                                  registration_id: '91827447385482', city: 'Rio de Janeiro',
                                  state: 'RJ', full_address: 'Avenida Castelão. 423',
                                  email: 'ouv@lannister.com', phone: '2637920382')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select "GRU - Aeroporto SP", from: 'Galpão destino'
    select "Waystar Roy Group Inc - CNPJ: 56.478.345/2184-39", from: 'Fornecedor'
    fill_in 'Data prevista para entrega', with: '30/12/2022'
    click_on 'Gravar'
    
    #Assert 
    expect(page).to have_content('Pedido registrado com sucesso')
    expect(page).to have_content("Pedido ABC12345")
    expect(page).to have_content('GRU - Aeroporto SP')
    expect(page).to have_content('Waystar Roy Group Inc')
    expect(page).to have_content('Mariana - mari@mari.com')
    expect(page).to have_content('30/12/2022')
    expect(page).not_to have_content('Galpão Rio')
    expect(page).not_to have_content('Lannister Brasil LTDA')



  end

  it 'sem sucesso se data for passada'do
    #Arrange
    user = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    Warehouse.create!(name: 'Galpão Rio', code: 'SDU' , city: 'Rio de Janeiro',
                    state: 'RJ', cep: '80000000', address: 'Rua do Malandro, 22',
                    area: 60_000, useful_area:50_000,
                    description:'Galpão principal do Rio de Janeiro')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                area: 100_000, useful_area: 80_000,
                                address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                                description: 'Galpão destinado para cargas internacionais')
    Supplier.create!(corp_name:'Lannister Brasil LTDA', brand_name: 'Lannister',
                                  registration_id: '91827447385482', city: 'Rio de Janeiro',
                                  state: 'RJ', full_address: 'Avenida Castelão. 423',
                                  email: 'ouv@lannister.com', phone: '2637920382')
    supplier = Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                                registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                                full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                                phone: '3290906463')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')
    #Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select "GRU - Aeroporto SP", from: 'Galpão destino'
    select "Waystar Roy Group Inc - CNPJ: 56.478.345/2184-39", from: 'Fornecedor'
    fill_in 'Data prevista para entrega', with: '30/12/2021'
    click_on 'Gravar'
    
    #Assert 
    expect(page).to have_content('Pedido não pode ser registrado')
    expect(page).to have_content('Data prevista para entrega deve ser futura')
  



  end



end