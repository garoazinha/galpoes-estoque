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
  end
end
