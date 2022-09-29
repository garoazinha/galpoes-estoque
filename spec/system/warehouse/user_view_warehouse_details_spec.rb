require 'rails_helper'

describe 'Usuario visita página de detalhes de galpão' do
    it 'e vê informações adicionais' do
        #Arrange
        usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
        Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                         area: 100_000, useful_area: 80_000,
                         address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                         description: 'Galpão destinado para cargas internacionais')
        #Act
        login_as(usuario)
        visit(root_path)
        click_on('Aeroporto SP')
        #Assert

        expect(page).to have_content('Galpão GRU')
        expect(page).to have_content('Nome: Aeroporto SP')
        expect(page).to have_content('Cidade: Guarulhos, SP')
        expect(page).to have_content('Área: 100000 m²')
        expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
        expect(page).to have_content('Galpão destinado para cargas internacionais')
        expect(page).to have_content('Área útil: 80000 m²')




    end
    it 'e volta a tela inicial' do 
        #Arrange
        usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
        Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                         area: 100_000, useful_area: 80_000, 
                         address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
                         description: 'Galpão destinado para cargas internacionais')
        #Act
        login_as(usuario)
        visit(root_path)
        click_on 'Aeroporto SP'
        click_on 'Voltar'
        #Assert
        expect(current_path).to eq('/')
    end
end