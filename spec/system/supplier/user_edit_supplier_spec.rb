require 'rails_helper'

describe 'Usuário edita fornecedor' do
  it 'a partir da página de fornecedores' do
    #Arrange
    Supplier.create(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                    registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                    full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                    phone: '3290906463')
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')

    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Waystar Roy'
    click_on 'Editar'
    #Assert
    expect(page).to have_content('Editar fornecedor')
    expect(page).to have_field('Razão social', with: 'Waystar Roy Group Inc')
    expect(page).to have_field('Nome fantasia', with: 'Waystar Roy')
    expect(page).to have_field('CNPJ', with: '56478345218439')
    expect(page).to have_field('Cidade', with: 'São Paulo')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('Endereço completo', with: 'Rodovia do Cacau, 300')
    expect(page).to have_field('E-mail', with: 'contato@waystar.com')
    expect(page).to have_field('Telefone', with: '3290906463')

  end

  it 'com sucesso' do
    #Arrange
    Supplier.create(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                    registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                    full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                    phone: '3290906463')
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Waystar Roy'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: 'Waystar Roy'
    fill_in 'CNPJ', with: '00000345218439'
    fill_in 'Razão social', with: 'Waystar Roy Group INC'
    click_on 'Atualizar'

    #Assert
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Razão social: Waystar Roy Group INC')
    expect(page).to have_content('Nome fantasia: Waystar Roy')
    expect(page).to have_content('CNPJ: 00.000.345/2184-39')

    
  end

  it 'e mantém os dados obrigatórios' do
    #Arrange
    Supplier.create(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                    registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                    full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                    phone: '3290906463')
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Waystar Roy'
    click_on 'Editar'
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Razão social', with: ''
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content('Fornecedor não pode ser atualizado')
    expect(page).to have_content('Nome fantasia não pode ficar em branco')
    expect(page).to have_content('Razão social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')


  end
end