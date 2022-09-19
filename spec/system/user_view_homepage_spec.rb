require 'rails_helper'
describe 'Usuario visita tela inicial' do
    it 'e vê o nome da app' do 
        #Arrange
        #Act
        visit(root_path)


        #Assert
        expect(page).to have_content('Sistema de Galpões & Estoque')

    end

    it 'e vê os galpões cadastrados' do
      #Arrange
      Warehouse.create(name: 'Rio', code: 'SDU' , city: 'Rio de Janeiro',
                     state: 'RJ', cep: '80000-000',
                     area: 60_000, useful_area:50_000,
                     description:'Galpão principal do Rio de Janeiro')
      Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio',
                     state:'AL', cep: '600000-000',
                     area: 50_000, useful_area:43_000, description:'Bom tbm')

      #Act
      visit(root_path)
      #Assert
      expect(page).to have_content('Rio')
      expect(page).to have_content('Código: SDU')
      expect(page).to have_content('Cidade: Rio de Janeiro, RJ')
      expect(page).to have_content('60000 m2')

      expect(page).to have_content('Maceio')
      expect(page).to have_content('Código: MCZ')
      expect(page).to have_content('Cidade: Maceio')
      expect(page).to have_content('50000 m2')

      expect(page).not_to have_content('Não existem galpões cadastrados')
    end

    it 'e não tem galpões cadastrados' do
        #Arrange
        #Act
        visit(root_path)
        #Assert
        expect(page).to have_content('Não existem galpões cadastrados')

    end
    
end