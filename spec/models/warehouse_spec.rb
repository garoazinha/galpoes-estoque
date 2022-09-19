require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'for presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: '', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when city is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: '', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when state is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: '',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when CEP is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when address is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: '',
                          area: 30000, useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when area is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: '', useful_area: 25000, description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when useful area is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: '', description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
      it 'false when description is empty' do
        #Arrange
        warehouse = Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                          cep: '65400-000', address: 'Rua do Machado, 44',
                          area: 30000, useful_area: 25000, description: '')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq(false)
      end
    end
    context 'for uniqueness' do
      it 'false when code is in use' do
        #Arrange
        first_warehouse = Warehouse.create(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                                          cep: '65400-000', address: 'Rua do Machado, 44',
                                          area: 30000, useful_area: 25000,
                                          description: 'Insumos industriais')
                                        
        second_warehouse = Warehouse.new(name:'Anapolis', code: 'GOC', city: 'Anapolis', state: 'GO',
                                         cep: '66400-000', address: 'Rua do Martelo, 45',
                                         area: 40000, useful_area: 35000,
                                         description: 'Insumos agrícolas')
        #Act
        result = second_warehouse.valid?
        #Assert
        expect(result).to eq(false)

      end
    end
    context 'for zipcode length and format' do
      it 'false when length not 9' do
        #Arrange
        warehouse= Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                                  cep: '65400-00', address: 'Rua do Machado, 44',
                                  area: 30000, useful_area: 25000,
                                  description: 'Insumos industriais')

        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to be_falsy
      end
      it 'false when format not 00000-000' do
        #Arrange
        warehouse= Warehouse.new(name:'Goiasnia', code: 'GOC', city: 'Goiania', state: 'GO',
                                cep: '65400-aaa', address: 'Rua do Machado, 44',
                                area: 30000, useful_area: 25000,
                                description: 'Insumos industriais')
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to be_falsy
        
      end
    end
  end
end
