require 'rails_helper'
describe 'Usuário vê lista de fornecedores' do
  it 'em seu próprio menu' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')

    #Act
    login_as(usuario)
    visit root_path
    within('nav') do
     click_on 'Fornecedores'
    end
    #Assert
    expect(current_path).to eq(suppliers_path)
  end
  it 'com sucesso' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                     registration_id: '56478345321843', city: 'São Paulo', state: 'SP',
                     full_address: 'Rodovia do Cacau, 300', email:'contato@nestinc.com',
                     phone: '3290906463')
    Supplier.create!(corp_name:'Lannister Brasil LTDA', brand_name: 'Lannister',
                     registration_id: '91827447385482', city: 'Rio de Janeiro', state: 'RJ',
                     full_address: 'Avenida Castelão. 423', email: 'ouv@lannister.com',
                     phone: '2637920382')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Waystar Roy')
    expect(page).to have_content('Lannister')
    
    
  end
  it 'e não há fornecedores cadastrados' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content('Não há fornecedores cadastrados')

  end
  
end