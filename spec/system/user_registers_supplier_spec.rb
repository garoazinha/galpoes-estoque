require 'rails_helper'

describe 'Usuário registra novo fornecedor' do
  it 'a partir da página de fornecedores' do
    #Arrange

    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    #Assert
    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('Razão social')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Endereço completo')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Telefone')
    
  end

  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão social', with: 'Waystar Royco Group INC'
    fill_in 'Nome fantasia', with: 'Waystar Royco'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Endereço completo', with: 'Avenida do Romano, 2930'
    fill_in 'CNPJ', with: '39402050491024'
    fill_in 'E-mail', with: 'contato@waystar.com'
    fill_in 'Telefone', with: '3290906463'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Waystar Royco')
    expect(page).to have_content('São Paulo, SP')
    expect(page).to have_content('Fornecedor cadastrado com sucesso')

  end

  it 'com dados incompletos' do
    #Arrange
    
    #Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    click_on 'Enviar'
    #Assert 
    expect(page).to have_content('Fornecedor não cadastrado')
    expect(page).to have_content('Nome fantasia não pode ficar em branco')
    expect(page).to have_content('Razão social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    

  end
end