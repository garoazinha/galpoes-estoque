require 'rails_helper'

describe 'Usuário edita modelo de produto' do
  it 'a partir da página de detalhes' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    first_sup = Supplier.create!(corp_name: 'Samsung Eletronicos LTDA',
                        brand_name: 'Samsung', registration_id: '12345678123456',
                        city: 'São Paulo', state: 'SP', full_address: 'Avenida Naçoes Unidas, 1000',
                        email: 'sac@samsung.com', phone: '11098761234')
    second_sup = Supplier.create!(corp_name: 'LG Eletronicos LTDA',
                                  brand_name: 'LG', registration_id: '12345678123776',
                                  city: 'São Paulo', state: 'SP', full_address: 'Avenida Presidente Amigo, 900',
                                  email: 'sac@lg.com', phone: '11098761674')
    ProductModel.create(name: 'TV 32', sku: 'TV32-SAMSU-XPTO90000',
                         width: 70, height: 45 , depth: 10, weight: 8000, supplier: first_sup)
    ProductModel.create(name: 'SoundBar 7.1 Surround', sku: 'SOU71-SAMSU-NOIZ71AB', width: 80, height: 15,
                        depth: 20 , weight: 3000, supplier: second_sup)

    #Act
    login_as(usuario)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    click_on 'Editar'
    fill_in 'Nome', with: 'TV 32"'
    fill_in 'Largura', with: '80'
    select 'LG', from: 'Fornecedor'
    click_on 'Atualizar'
    #Assert
    expect(page).to have_content('TV 32"')
    expect(page).to have_content('Dimensões: 80cm x 45cm x 10cm')
    expect(page).to have_content('Fornecedor: LG')

  end
end