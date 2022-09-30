require 'rails_helper'
describe 'Usuário vê modelos de produto' do
  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_path
    within('nav') do
     click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'a partir do menu' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    within('nav') do
     click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq(product_models_path)
    
  end
  it 'com sucesso' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    x = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                        brand_name: 'Samsung', registration_id: '12345678123456',
                        city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                        email: 'sac@samsung.com', phone: '11098761234')
    ProductModel.create(name: 'TV 32', sku: 'TV32-SAMSU-XPTO90000',
                         width: 70, height: 45 , depth: 10, weight: 8000, supplier: x)
    ProductModel.create(name: 'SoundBar 7.1 Surround', sku: 'SOU71-SAMSU-NOIZ71AB', width: 80, height: 15,
                         depth: 20 , weight: 3000, supplier: x)
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Modelos de Produtos'
    #Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPTO90000')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SOU71-SAMSU-NOIZ71AB')
    expect(page).to have_content('Samsung')

  end

  it 'e não existem produtos cadastrados' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Modelos de Produtos'
    #Assert
    expect(page).to have_content('Não existem modelos de produtos cadastrados')
  end

  it 'em página de fornecedores' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    x = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                        brand_name: 'Samsung', registration_id: '12345678123456',
                        city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                        email: 'sac@samsung.com', phone: '11098761234')
    ProductModel.create!(name: 'TV 32', sku: 'TV32-SAMSU-XPTO90000',
                        width: 70, height: 45 , depth: 10, weight: 8000, supplier: x)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', sku: 'SOU71-SAMSU-NOIZ71AB', width: 80, height: 15,
                         depth: 20 , weight: 3000, supplier: x)

    #Act
    login_as(usuario)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Samsung'
    #Assert 
    expect(page).to have_content('Produtos deste fornecedor')
    expect(page).to have_content('TV 32')
    expect(page).to have_content('SKU: TV32-SAMSU-XPTO90000')
    expect(page).to have_content('Dimensões: 70cm x 45cm x 10cm')
    expect(page).to have_content('Peso: 8000g')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SKU: SOU71-SAMSU-NOIZ71AB')
    expect(page).to have_content('Dimensões: 80cm x 15cm x 20cm')
    expect(page).to have_content('Peso: 3000g')
    
  end
 end