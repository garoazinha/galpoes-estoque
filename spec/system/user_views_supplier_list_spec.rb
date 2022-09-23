require 'rails_helper'
describe 'Usuário vê lista de usuários' do
  it 'em seu próprio menu' do
    #Arrange

    #Act
    visit root_path
    within('nav') do
     click_on 'Fornecedores'
    end
    #Assert
    expect(current_path).to eq(suppliers_path)
  end
  it 'com sucesso' do
    #Arrange
    Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                     registration_id: '5647834521843', city: 'São Paulo', state: 'SP',
                     full_address: 'Rodovia do Cacau, 300', email:'contato@nestinc.com')
    Supplier.create!(corp_name:'Lannister Brasil LTDA', brand_name: 'Lannister',
                     registration_id: '9182744738482', city: 'Rio de Janeiro', state: 'RJ',
                     full_address: 'Avenida Castelão. 423', email: 'ouv@lannister.com')
    #Act
    visit root_path
    click_on 'Fornecedores'

    #Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Waystar Roy')
    expect(page).to have_content('Lannister')
    
    
  end
  it 'e não há fornecedores cadastrados' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    #Assert
    expect(page).to have_content('Não há fornecedores cadastrados')

  end
  
end