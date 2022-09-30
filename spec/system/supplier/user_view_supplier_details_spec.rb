require 'rails_helper'

describe 'Usuário vê detalhes de fornecedores' do
  it 'em página de detalhes' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                      registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Waystar Roy'

    #Assert
    expect(page).to have_content('Waystar Roy')
    expect(page).to have_content('Razão social: Waystar Roy Group Inc')
    expect(page).to have_content('CNPJ: 56.478.345/2184-39')
    expect(page).to have_content('Endereço: Rodovia do Cacau, 300 / São Paulo - SP')
    expect(page).to have_content('E-mail: contato@waystar.com')

    
    
  end
  it 'e volta para a tela de fornecedores' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                    registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                    full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                    phone: '3290906463')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Waystar Roy'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq(suppliers_path)
    
  end
end