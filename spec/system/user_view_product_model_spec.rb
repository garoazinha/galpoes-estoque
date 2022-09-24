require 'rails_helper'
describe 'Usuário vê modelos de produto' do
  it 'a partir do menu' do
    #Arrange
    #Act
    visit root_path
    within('nav') do
     click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq(product_models_path)
    
  end
  it 'com sucesso' do
    #Arrange
    x = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                               brand_name: 'Samsung', registration_id: '12345678123456',
                               city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                               email: 'sac@samsung.com', phone: '11098761234')
    ProductModel.create!(name: 'TV 32', sku: 'TV32-SAMSU-XPTO90',
                         width: 70, height: 45 , length: 10, weight: 8000, supplier: x)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', sku: 'SOU71-SAMSU-NOIZ77', width: 80, height: 15,
                         length: 20 , weight: 3000, supplier: x)
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    #Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('SOU71-SAMSU-NOIZ77')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SOU71-SAMSU-NOIZ77')
    expect(page).to have_content('Samsung')

  end

  it 'e não existem produtos cadastrados' do
    #Arrange
    #Act
    visit root_path
    click_on 'Modelos de Produtos'
    #Assert
    expect(page).to have_content('Não existem modelos de produtos cadastrados')
  end
end