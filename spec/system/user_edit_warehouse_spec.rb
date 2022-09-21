require 'rails_helper'

describe 'Usuário edita dados de galpão' do
    it 'a partir da página de detalhes' do
        #Arrange
        w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                    area: 100_000, useful_area: 80_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
        #Act
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar'

        #Assert
        expect(page).to have_content('Editar galpão')
        expect(page).to have_field('Nome', with: 'Aeroporto SP')
        expect(page).to have_field('Código', with: 'GRU')
        expect(page).to have_field('Cidade', with: 'Guarulhos')
        expect(page).to have_field('Estado', with: 'SP')
        expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
        expect(page).to have_field('CEP', with: '15000-000')
        expect(page).to have_field('Área', with: '100000')
        expect(page).to have_field('Área útil', with: '80000')
        expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')

    end
    it 'com sucesso' do
        #Arrange
        w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                                    area: 100_000, useful_area: 80_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                                    description: 'Galpão destinado para cargas internacionais')
        #Act
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar'
        fill_in 'Nome', with: 'Galpão Guarulhos'
        fill_in 'Área', with: '150000'
        fill_in 'CEP', with: '16000-000'
        fill_in 'Descrição', with: 'Galpão destinado para cargas nacionais e internacionais'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Nome: Galpão Guarulhos')
        expect(page).to have_content('Área: 150000 m2')
        expect(page).to have_content('CEP: 16000-000')
        expect(page).to have_content('Galpão destinado para cargas nacionais e internacionais')
        expect(page).to have_content('Galpão atualizado com sucesso')

    end
    it 'e mantém os dados obrigatórios' do
        #Arrange
        w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
                              area: 100_000, useful_area: 80_000,
                              address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
                              description: 'Galpão destinado para cargas internacionais')
        #Act
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar'
        fill_in 'Nome', with: ''
        fill_in 'Área', with: ''
        fill_in 'CEP', with: ''
        
        click_on 'Enviar'
        #Assert
        
       
        expect(page).to have_content('Galpão não pode ser atualizado')

        
    end
end