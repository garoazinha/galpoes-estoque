require 'rails_helper'

describe 'Usuário remove um galpão' do
    it 'com sucesso' do
        #Arrange 
        usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
        w = Warehouse.create!(name:'Campo Grande', code: 'CGR', city: 'Campo Grande', state: 'MS', 
                                area: 20_000, useful_area: 15_000, address: 'Rua do Jabuti, 33',
                                cep: '66699000', description: 'Galpão para mercadoria da fronteira')     
        #Act
        login_as(usuario)
        visit root_path
        click_on 'Campo Grande'
        click_on 'Remover'
        #Assert
        expect(current_path). to eq(root_path)
        expect(page).not_to have_content('Campo Grande')
        expect(page).not_to have_content('CGR')
        expect(page).to have_content('Galpão removido com sucesso')
    end
    
    it 'e não apaga outros galpoes' do
        #Arrange
        usuario = User.create!(name: 'Mariana', email: 'mari@mari.com', password: 'password')
        first_warehouse = Warehouse.create!(name:'Campo Grande', code: 'CGR', city: 'Campo Grande', state: 'MS', 
                                            area: 20_000, useful_area: 15_000, address: 'Rua do Jabuti, 33',
                                            cep: '66699000', description: 'Galpão para mercadoria da fronteira')
        second_warehouse = Warehouse.create!(name:'Fortaleza', code: 'FFR', city: 'Fortaleza', state: 'CE', 
                                            area: 50_000, useful_area: 45_000, address: 'Rua do Galo, 44',
                                            cep: '67799000', description: 'Galpão para mercadoria do porto')
        #Act
        login_as(usuario)
        visit root_path
        click_on 'Campo Grande'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Galpão removido com sucesso')
        expect(page).to have_content('Fortaleza')
        expect(page).not_to have_content('Campo Grande')
        
    end
    
end