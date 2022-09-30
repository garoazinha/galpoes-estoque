require 'rails_helper'

describe 'Usuário vê detalhes de produtos' do
  it 'a partir da página inicial' do
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
    click_on 'TV 32'
    #Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('Dimensões: 70cm x 45cm x 10cm')
    expect(page).to have_content('Peso: 8000g')
    expect(page).to have_content('Fornecedor: Samsung')

  end
end