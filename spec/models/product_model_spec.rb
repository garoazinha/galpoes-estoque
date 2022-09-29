require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valido?' do
    it 'nome é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: '', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'sku é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: '',
                               width: 12, height: 18, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'largura é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: nil, height: 18, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'peso é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: 2, weight: nil, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'profundidade é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: nil, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'altura é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: nil, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end
    it 'fornecedor é obrigatório' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: nil, depth: 2, weight: 50, supplier: nil)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'falso se largura é menor ou igual a zero' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 0, height: 18, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'falso se altura é menor igual a zero' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 0, depth: 2, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'falso se profundidade é menor ou igual a zero' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: 0, weight: 50, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'falso se peso é menor ou igual a zero' do
      #Arrange
      sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: 2, weight: -20, supplier: sup)
      #Act
      resultado = pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end

    it 'falso se sku não é único' do
      #Arrange
      first_sup = Supplier.create!(corp_name: 'HP Industries INC', brand_name: 'HP', city: 'São Paulo',
                             state:'SP', registration_id: '12345678909876', email: 'ouv@hp.com', 
                             phone: '11234561234')
      second_sup = Supplier.create!(corp_name: 'Sony Corporation INC', brand_name: 'Sony', city: 'São Paulo',
                              state:'SP', registration_id: '12345678902076', email: 'sac@sony.com', 
                              phone: '11234561224')
      first_pm = ProductModel.create(name: 'Calculadora HPX30a', sku: 'CALCX30-HP-HPCX30ABC',
                               width: 12, height: 18, depth: 2, weight: 70, supplier: first_sup)
      second_pm = ProductModel.create(name: 'Calculadora HPX30b', sku: 'CALCX30-HP-HPCX30ABC',
                                width: 13, height: 20, depth: 2, weight: 65, supplier: second_sup)
      

      #Act
      resultado = second_pm.valid?
      #Assert
      expect(resultado).to be_falsy
    end
  end
end
