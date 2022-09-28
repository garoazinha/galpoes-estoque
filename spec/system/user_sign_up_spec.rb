require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    #act 
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'mari@mari.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Nome', with: "Mariana S"
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    #Assert
    expect(page).to have_content('Você realizou seu registro com sucesso')
    #expect(page).to have_content('Olá Mariana S')
    expect(page).to have_content('mari@mari.com')
    expect(page).to have_button('Sair')
    user = User.last
    expect(user.name).to eq('Mariana S')    

  end
  
end