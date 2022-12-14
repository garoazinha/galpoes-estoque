require 'rails_helper'
describe 'Usuário registra novo galpao' do
  it 'a partir da tela inicial' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Cadastrar galpão'
    #Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
    expect(page).to have_field('Área útil')
    expect(page).to have_field('Descrição')
  end

  it 'com sucesso' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')

    #Act
    login_as(usuario)
    visit root_path
    click_on 'Cadastrar galpão'
    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Código', with: 'RIO'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Área', with: '40000'
    fill_in 'Área útil', with: '33000'
    fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
    click_on 'Enviar'

    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RIO')
    expect(page).to have_content('40000 m²')
    expect(page).to have_content('Galpão cadastrado com sucesso')
  end

  it 'com dados incompletos' do
    #Arrange
    usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
    
    #Act
    login_as(usuario)
    visit root_path
    click_on 'Cadastrar galpão'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'
    
    #Assert
    expect(page).to have_content('Galpão não cadastrado')
    expect(page).to have_content('Nome não pode ficar em branco')   
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')      
    expect(page).to have_content('Código não pode ficar em branco') 
    expect(page).to have_content('Área não pode ficar em branco')   
    expect(page).to have_content('CEP não pode ficar em branco')   
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Área útil não pode ficar em branco') 
    expect(page).to have_content('Descrição não pode ficar em branco') 
    expect(page).to have_content('CEP em formato errado (00000-000)')      
    
  end
end
