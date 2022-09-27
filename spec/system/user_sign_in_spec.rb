require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Mariana', email:'mari@mari.com', password: 'password')
    #Act
    visit root_path
    click_on 'Entrar'
    
    within('form') do
      fill_in 'E-mail', with: 'mari@mari.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    #Assert
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')

    within('nav') do
      expect(page).to have_content('mari@mari.com')
    end
    expect(page).to have_content('Login efetuado com sucesso')
  end
end