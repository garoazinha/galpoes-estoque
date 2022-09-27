require 'rails_helper'

describe 'Usuário cadastra novo modelo de produto' do
  it 'com sucesso' do
    #Arrange
    supplier = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                              brand_name: 'Samsung', registration_id: '12345678123456',
                              city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                              email: 'sac@samsung.com', phone: '11098761234')
    other_supplier = Supplier.create!(corp_name: 'LG Eletronicos LTDA',
                                brand_name: 'LG', registration_id: '12345678123776',
                                city: 'São Paulo', state: 'SP', full_address: 'Avenida Presidente Amigo, 900',
                                email: 'sac@lg.com', phone: '11098761674')
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar novo modelo de produto'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'Peso', with: 5_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 100
    fill_in 'Profundidade', with: 25
    fill_in 'SKU', with: 'TV40-SAMSU-XPTO90000'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Criar'
    #Assert
    expect(page).to have_content('Modelo de produto cadastrado com sucesso')
    expect(page).to have_content('TV 40 polegadas')
    expect(page).to have_content('SKU: TV40-SAMSU-XPTO90')
    expect(page).to have_content('Dimensões: 100cm x 60cm x 25cm')
    expect(page).to have_content('Peso: 5000g')
    expect(page).to have_content('Fornecedor: Samsung')
  end

  it 'deve preencher todos os campos' do
    #Arrange
    supplier = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                                brand_name: 'Samsung', registration_id: '12345678123456',
                                city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                                email: 'sac@samsung.com', phone: '11098761234')
    
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar novo modelo de produto'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''

    click_on 'Criar'
    #Assert
    expect(page).to have_content('Não foi possível cadastrar modelo de produto')
    
  end
end